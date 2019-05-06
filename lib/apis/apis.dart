final String GIFS = "https://api.giphy.com/v1/gifs/trending?api_key=6Ik8CDELdWwEsNyYhjSRjQ8ikyrPjiGO&limit=20&rating=G";
search(String search, int offset){
  return "https://api.giphy.com/v1/gifs/search?api_key=6Ik8CDELdWwEsNyYhjSRjQ8ikyrPjiGO&q=$search&limit=19&offset=$offset&rating=G&lang=en";
}
