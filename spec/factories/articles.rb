FactoryBot.define do
  factory :article do
    sequence (:title) { |t| "Article N°#{t} Title." }
    sequence (:content) { |t| "Article N°#{t} content section..." }
    sequence (:slug) { |t| "slug-for-article-#{t}" }
  end
end
