class Variant < ActiveRecord::Base

  has_and_belongs_to_many :variant_option_values

  belongs_to :product, inverse_of: :variants

  def add_fields(options)
    options.each do |option|
      self.class.send(:define_method, option.latin_name.to_sym) do |argument|
        if argement.present?
          variant_option_values << argument
        else
          option.variant_option_values.find(option.variant_option_value.ids & variant_option_values.ids).first
        end
      end
    end
  end


  # def method_missing(method_sym, *arguments, &block)
  #
  #   return super unless /^(.*)_option$/ =~ method_sym.to_s
  #   option_latin_name = method_sym.to_s.slice("_option")
  #   if arguments.any?
  #     unless variant_option_values.include?(arguments.first)
  #       variant_option_values << arguments.first
  #     end
  #   else
  #     option = VariantOption.includes(:variant_option_values).where(latin_name: option_latin_name).first
  #     option.variant_option_values.find((option.variant_option_value.ids & variant_option_values).first.to_i)
  #   end
  #
  # end


end
