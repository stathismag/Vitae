# # For PDF
install.packages("rmarkdown")
# Set the working directory
setwd("C:/Users/user/Documents/GitHub/Vitae")

file.copy("content/about-source.md", "static/magerakis-cv.Rmd", overwrite=TRUE)
rmarkdown::render("static/magerakis-cv.Rmd", output_format = "pdf_document")

# CRAN version
install.packages('tinytex')

file.copy("static/magerakis-cv.pdf", "static/cv/magerakis-cv.pdf", overwrite=TRUE)

## For Word
file.copy("content/about.md", "content/about-for-cv.md", overwrite=TRUE)
cv_word <- readLines("content/about-for-cv.md")

cv_word <- cv_word[cv_word!="\\begin"]
cv_word <- cv_word[cv_word!="\\begin"]
cv_word <- cv_word[cv_word!="\\textit"]
cv_word[stringr::str_detect(cv_word, "Curriculum Vitae")] <- "*Curriculum Vitae*"
cv_word <- cv_word[cv_word!="\\begingroup"]
cv_word <- cv_word[cv_word!="\\hangindent=2em"]
cv_word <- cv_word[cv_word!="\\center"]
cv_word <- cv_word[cv_word!="\\endgroup"]

writeLines(unlist(cv_word), "static/cv/magerakis-cv-for-word.Rmd")
rmarkdown::render("static/cv/magerakis-cv-for-word.Rmd", output_format = "word_document")

## For HTML
file.copy("content/about-source.md", "content/about.md", overwrite=TRUE)

cv_html <- readLines("content/about.md")

find_yml <- stringr::str_detect(cv_html, "---")
end_of_yml <- which(find_yml)[2]
cv_html <- append(cv_html, "PDF version: <a href = 'http://jmichaelrosenberg.com/rosenberg-cv.pdf'> <img src='/logos/pdf.png' style='width: 25px; height: 25px;'/></a>", after = end_of_yml)

cv_html <- cv_html[cv_html!="\\begin{center}"]
cv_html <- cv_html[cv_html!="\\end{center}"]
cv_html[stringr::str_detect(cv_html, "Curriculum Vitae")] <- "*Curriculum Vitae*"
cv_html <- cv_html[cv_html!="\\begingroup"]
cv_html <- cv_html[cv_html!="\\hangindent=2em"]
cv_html <- cv_html[cv_html!="\\center"]
cv_html <- cv_html[cv_html!="\\endgroup"]

writeLines(unlist(cv_html), "content/about.md")

