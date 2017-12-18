FactoryGirl.define do
  factory :attachment do
    # transient attributes allow you to pass in data that isn’t an attribute on the model.
    transient do
      file_to_attach "spec/fixtures/speed.txt"
    end

    file { File.open file_to_attach }
  end
end
