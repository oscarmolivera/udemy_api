(1..25).each_with_index do |article, index|
  Article.create!(
    {
      "title" => "TITULO XXX-XXXX-XXXX Articulo N°#{index+1}",
      "content" => "Contenido #{index+1}: Lorem Ipsum ...",
      "slug" => "page-articulo-#{index+1}"
    }
  )
end
puts "25 Articulos creados!"