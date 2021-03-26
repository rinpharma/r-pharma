## Generate credentials for gsheet access

#pw_name <- gargle:::secret_pw_name("googlesheets4")
#pw <- gargle:::secret_pw_gen()

# added pwname_pw to usethis::edit_r_environ()

# encrypt the service account token (I made via goodle dev console)
# gargle:::secret_write(
#   package = "googlesheets4",
#   name = "rinpharma-4ac2ad6eba3b.json",
#   input = "~/Downloads/rinpharma-4ac2ad6eba3b.json"
# )

# encrypted file is now in /inst/

# file_name <- "rinpharma-4ac2ad6eba3b.json"
# secret_name <- "googlesheets4"
# path <- paste0("inst/secret/", file_name)
# raw <- readBin(path, "raw", file.size(path))
# json <- sodium::data_decrypt(
#   bin = raw, key = gargle:::secret_pw_get(secret_name), 
#   nonce = gargle:::secret_nonce()
#   )
# pass <- rawToChar(json)
# 
# gs4_auth(path = pass)

