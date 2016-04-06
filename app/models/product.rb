class Product < ActiveRecord::Base

  has_and_belongs_to_many :taxons

  belongs_to :prototype, inverse_of: :products

  has_and_belongs_to_many :product_property_values

  has_many :variants, inverse_of: :product, dependent: :destroy

  accepts_nested_attributes_for :variants

  validates :name, :slug, presence: true

  # TODO: rename function like add_properties_fileds
  # TODO: rewrite like taxons function for use multiple and single mode
  def add_fields(properties)
    properties.each do |property|
      self.class.send(:define_method, "#{property.latin_name}") do
        property_id = (property.product_property_values.ids & product_property_values.map{ |p| p.id }).first
        value = nil
        if property_id.present?
          value = ProductPropertyValue.find(property_id)
        end
        value
      end
      self.class.send(:define_method, "#{property.latin_name}=") do |argument|
        unless (argument.to_i == 0)
          property.product_property_values.each do |value|
            product_property_values.delete(value)
          end
          product_property_values << ProductPropertyValue.find(argument.to_i)
        end
      end
    end
  end

  def add_taxons_fields(taxonomies)
    taxonomies.each do |taxonomy|
      self.class.send(:define_method, "#{taxonomy.latin_name}") do
        if taxonomy.multiple?
          taxon_ids = taxonomy.taxons.ids & taxons.map{ |t| t.id }
          taxon_ids.map{ |t| Taxon.find(t) }
        else
          taxon_id = (taxonomy.taxons.ids & taxons.map{ |t| t.id }).first
          value = nil
          if taxon_id.present?
            value = Taxon.find(taxon_id)
          end
          value
        end
      end
      self.class.send(:define_method, "#{taxonomy.latin_name}=") do |arguments|
        if arguments.present?
          if taxonomy.multiple?
            taxonomy.taxons.each do |value|
              taxons.delete(value)
            end
            arguments.each do |argument|
              taxons << Taxon.find(argument) if argument.present?
            end
          else
            unless (arguments.to_i == 0)
              taxonomy.taxons.each do |value|
                taxons.delete(value)
              end
              taxons << Taxon.find(arguments.to_i)
            end
          end
        end
      end
    end
  end

end
