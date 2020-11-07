branch=$1

git diff $branch..develop --name-only |\
    grep example |\
    grep src/main/scala |\
    xargs -I dir find dir -type f -name "*" |\
    sed 's/^.*src\/main\/scala\///g' |\
    grep -E 'scala$' |\
    sed 's/\//\./g' |\
    sed 's/\.scala/\.main(null)/g' |\
    awk 'BEGIN {
	    print "var arr = Array.empty[String]" 
	 }
	 {
            print "if (scala.util.Try[Unit]\{ "$0" \}.isFailure) {\narr :+= \""$0"\"\n}"
	 }
	 END {
	    print "println(arr.mkString(\"\\n\"))"
	 }' 
