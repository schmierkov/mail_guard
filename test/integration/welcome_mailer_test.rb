require 'test_helper'

describe "WelcomeMailer" do
  let(:interceptor) { MailGuard.new(interceptor_params) }
  let(:register_interceptor) do
    ActionMailer::Base.register_interceptor(interceptor)
  end
  let(:message_params) { { to: "hello@hello.de", subject: "Hello World!" } }
  let(:email) { WelcomeMailer.hello(message_params).send DELIVER_METHOD }

  before do
    register_interceptor
  end

  after do
    Mail.class_variable_set(:@@delivery_interceptors, [])
  end

  describe "interceptor with default prefix enabled" do
    let(:interceptor_params) { { subject_prefix: true } }

    it "adds default prefix to subject" do
      assert_equal "[TEST] Hello World!", email.subject
    end
  end

  describe "interceptor with custom prefix enabled" do
    let(:interceptor_params) { { subject_prefix: "FOOFIX" } }

    it "adds custom prefix to subject" do
      assert_equal "FOOFIX Hello World!", email.subject
    end

    it "replaces recipients" do
      assert_equal ["default@example.com"], email.to
    end
  end

  describe "blank interceptor" do
    let(:interceptor_params) { {} }

    it "does not add prefix to subject" do
      assert_equal "Hello World!", email.subject
    end

    it "replaces recipients" do
      assert_equal ["default@example.com"], email.to
    end
  end

  describe "interceptor with permitted_hosts" do
    let(:interceptor_params) { { permitted_hosts: ["hello.de"] } }

    it "does not replace email recipient" do
      assert_equal ["hello@hello.de"], email.to
    end

    describe "email to hello@foo.com" do
      let(:message_params) { { to: "hello@foo.com" } }

      it "replaces recipients with default" do
        assert_equal ["default@example.com"], email.to
      end
    end
  end

  describe "interceptor with recipients" do
    let(:interceptor_params) { { recipients: ["foo@bar.com"] } }

    it "replaces recipients with interceptor recipients" do
      assert_equal ["foo@bar.com"], email.to
    end
  end
end
