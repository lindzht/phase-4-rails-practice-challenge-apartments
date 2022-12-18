class ErrorMessageSerializer < ActiveModel::Serializer
  
  def self.messages(errors)
    errors.map do |error|
      "#{error.attribute} #{error.message}"
    end
  end



end
