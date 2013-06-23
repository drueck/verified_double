require 'rspec/fire'

require 'verified_double/boolean'
require 'verified_double/method_signature'
require 'verified_double/method_signature_value'
require 'verified_double/method_signatures_report'
require 'verified_double/parse_method_signature'
require 'verified_double/recording_double'
require 'verified_double/relays_to_internal_double_returning_self'

module VerifiedDouble
  def self.of_class(class_name, method_stubs = {})
    class_double = RSpec::Fire::FireClassDoubleBuilder.build(class_name).as_replaced_constant
    RecordingDouble.new(class_double, method_stubs).tap do |double|
      registry << double
    end
  end

  def self.of_instance(class_name, method_stubs = {})
    instance_double = RSpec::Fire::FireObjectDouble.new(class_name)
    RecordingDouble.new(instance_double, method_stubs).tap do |double|
      registry << double
    end
  end

  def self.registry
    @registry ||= []
  end

  def self.report_unverified_signatures(nested_example_group)
    MethodSignaturesReport.new
      .set_registered_signatures
      .set_verified_signatures_from_tags(nested_example_group)
      .identify_unverified_signatures
      .output_unverified_signatures
  end
end

