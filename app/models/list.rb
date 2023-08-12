class List < ApplicationRecord
    belongs_to :author
    serialize :article_ids, Array
    serialize :shared_with, Array
end
