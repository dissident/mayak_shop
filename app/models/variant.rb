class Variant < ActiveRecord::Base

  has_and_belongs_to_many :variant_option_values

  belongs_to :product, inverse_of: :variants

  def method_missing(method_sym, *arguments, &block)

    return super unless /^(.*)_option(=?)/ =~ method_sym
    option_id = method_sym.to_s.split("_").first.to_i
    if arguments.any?
      unless variant_option_values.include?(arguments.first)
        variant_option_values << arguments.first
      end
    else
      option = VariantOption.includes(:variant_option_values).find(option_id)
      option.variant_option_values.find((option.variant_option_value.ids & variant_option_values).first.to_i)
    end

  end


end
