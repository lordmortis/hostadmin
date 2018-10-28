class Domain < ApplicationRecord
  include UUIDRecord

  @@features = {email: 0, wordpress: 1, rails: 2}.freeze
  has_many :domain_managers, dependent: :destroy

  def features=(values)
    self.features_store = features_array(values)
  end

  def features
    if features_store.is_a? Array
      features_store.collect { |x| @@features.key(x) }
    else
      []
    end
  end

private

  def features_array(values)
    if values.is_a? Array
      values.collect { |value| features_value(value) }.drop_while { |value| value.blank? }
    elsif values.is_a?(Symbol) || values.is_a?(String)
      [features_value(values)].drop_while { |value| value.blank? }
    else
      []
    end
  end

  def features_value(value)
    if value.is_a? Symbol
      @@features[value] if @@features.has_key? value
    elsif value.is_a? String
      symbol = value.to_sym
      features_value(symbol)
    end
  end
end
