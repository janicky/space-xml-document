#!/bin/bash

java -jar saxon9he.jar document.xml document-additional.xsl -o:out/document-additional.xml
java -jar saxon9he.jar out/document-additional.xml document-xhtml.xsl -o:out/document-xhtml.html
java -jar saxon9he.jar out/document-additional.xml document-txt.xsl -o:out/document-text.txt