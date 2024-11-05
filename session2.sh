#!/bin/bash

# giải nén thư mục zip
unzip session2.zip 
# chuyển path và tên file sang agrument
# lấy path do người dùng truyền vào default session2
# tìm hiểu những flag của set để xử lí tín hiệu

# đường dẫn cho file giải nén
path="session2"


for pdf_file in "$path"/*.pdf; do
    
    if [ ! -f "$pdf_file" ]; then
        echo "Không có file PDF nào trong thư mục $path."
        exit 1
    fi

    # lấy tên file không lấy phần mở rộng pdf
    name_file=$(basename "$pdf_file" .pdf)

    # chuyển pdf sang dạng text để xử lí
    pdftotext "$pdf_file" "$path/${name_file}.txt"

    # tách từ và lấy các từ duy nhất
    # câu lệnh tham khảo từ stackoverflow
    unique_words=$(tr ' ' '\n' < "$path/${name_file}.txt" | grep -oE '^[a-zA-Z]+' | sort -fu)

    # tạo thư mục tương ứng với các file .pdf
    mkdir -p "$path/$name_file"

    
    for word in $unique_words; do
        # Tạo file với tên từ và nội dung là từ đó
        echo "$word" > "$path/$name_file/$word.txt"
    done
    
    echo "Đã xử lý: $pdf_file -> $path/$name_file/"
done

rm -rf "$path"/*.txt

echo "Hoàn tất!"


