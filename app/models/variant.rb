class Variant < ActiveRecord::Base

  has_and_belongs_to_many :variant_option_values

  belongs_to :product, inverse_of: :variants

  def add_fields(options)
    options.each do |option|
      self.class.send(:define_method, option.latin_name.to_sym) do
        value_id = (option.variant_option_values.ids & variant_option_values.map{ |v| v.id }).first
        value = nil
        if value_id.present?
          value = VariantOptionValue.find(value_id)
        end
        value
      end
      self.class.send(:define_method, "#{option.latin_name}=") do |argument|
        unless (argument.to_i == 0) || variant_option_values.ids.include?(argument.to_i)
          variant_option_values << VariantOptionValue.find(argument.to_i)
        end
      end
    end
  end

end
