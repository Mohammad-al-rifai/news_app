// BaseURl:     https://newsapi.org/
// Method:      v2/top-headlines?
// Query:       country=eg&category=science&apiKey=39d00c418794463cbd26d56cf47408a8


// This Method UseFul For Print All Data From Json File!
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is The Size Of Each chunk
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}