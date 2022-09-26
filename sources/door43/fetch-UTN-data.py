from operator import add
import os
import requests
import pandas as pd
pd.options.mode.chained_assignment = None  # default='warn'

# This script loads the latest door43 figures of speech data from unfoldingWord. 
# It pulls all of the files from the github repo and stages their tsv data in 
# pandas dataframes. The filtered data from each file is combined and saved in a
# single tsv file. 

OT_WRITE_FILE = 'UTN-figures-of-speech-OT.tsv'
NT_WRITE_FILE = 'UTN-figures-of-speech-OT.tsv'

BOOK_NAMES = {
    'OT': {
        'GEN', 'EXO', 'LEV', 'NUM', 'DEU', 'JOS', 'JDG', 'RUT', '1SA', '2SA', '1KI', '2KI', '1CH', 
        '2CH', 'EZR', 'NEH', 'EST', 'JOB', 'PSA', 'PRO', 'ECC', 'SNG', 'ISA', 'JER', 'LAM', 'EZK', 
        'DAN', 'HOS', 'JOL', 'AMO', 'OBA', 'JON', 'MIC', 'NAM', 'HAB', 'ZEP', 'HAG', 'ZEC', 'MAL'},
    'NT': {
        'MAT', 'MRK', 'LUK', 'JHN', 'ACT', 'ROM', '1CO', '2CO', 'GAL', 'EPH', 'PHP', 'COL', '1TH', 
        '2TH', '1TI', '2TI', 'TIT', 'PHM', 'HEB', 'JAS', '1PE', '2PE', '1JN', '2JN', '3JN', 'JUD', 'REV'}
}


# A client to access the online UTN repository.
class UTNClient:

    root_url = 'https://git.door43.org/unfoldingWord/en_tn/'
    raw_file_url = 'raw/branch/master/'
    # Hit API to get file names in repository -- See: https://git.door43.org/api/swagger#/repository/repoGetContentsList
    repo_content_url = 'https://git.door43.org/api/v1/repos/unfoldingWord/en_tn/contents?ref=master'

    # Get all the file names for UTN tsv files. Takes set of either OT or NT books.
    def get_file_names(self, books):
       
        files_response = requests.get(self.repo_content_url)
        # Validate that API call was successful. 
        if files_response.status_code != 200:
            raise Exception(f"\n\nInvalid URL: {self.repo_content_url}\n\n")

        files_data = files_response.json()
        # Validate that API returned the correct data. 
        if not type(files_data) is list or "name" not in files_data[0]:
            raise Exception(
                '\n\nExpected to receive data from API in form [{"name":".github","path":".github"...}]' +
                f"\n\nBut received {files_data}\n\n")

        tsv_files = []

        for file_obj in files_data:
            
            file_name = file_obj.get("name")
            # file_name of format 'en_tn_01-GEN.tsv', split to get just the book name. 
            if "tsv" in file_name and file_name.split('-')[1].split('.')[0] in books:
                tsv_files.append(file_name)

        return tsv_files

    # Read a tsv file into a pandas df. 
    def get_file_df(self, file_name):
       
        file_path = self.root_url + self.raw_file_url + file_name 
        
        file_df = pd.read_csv(file_path, sep='\t')
        
        return file_df


# Parse UTN data and write to a single file. 
# Takes write_file name and book names from OT or NT.
def parse_utn_data(write_file, books):
   
    print("Fetching data from UTN Client")

    client = UTNClient()
    file_names = client.get_file_names(books)
    dataframes = []

    for fn in file_names:
        
        file_df = client.get_file_df(fn)
        
        # Filter df down to only keep rows containing figures of speech. 
        keep_df = file_df[file_df['SupportReference'].str.contains('figs', na=False)]
        keep_df.reset_index(drop=True)

        add_symphony_identifiers(keep_df)
        
        dataframes.append(keep_df)

        print(fn + " complete")
        
    # Merge all the data into a single df. 
    all_data = pd.concat(dataframes)

    print("Writing data to " + write_file)

    dir_path = os.path.dirname(os.path.realpath(__file__))
    write_path = os.path.join(dir_path, write_file)
    all_data.to_csv(write_path, sep="\t", index=False)


# Function to add Symphony identifiers.
def add_symphony_identifiers(df):
    
    for i, row in df.iterrows():
        
        book = row['Book']
        ref = row['Chapter'] + ':' + row['Verse']
        verse_id = book +  ' ' + ref
        
        df.at[i,'VerseId'] = verse_id


if __name__ == "__main__":

    parse_utn_data(OT_WRITE_FILE, BOOK_NAMES.get('OT'))
 

