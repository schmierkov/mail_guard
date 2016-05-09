require 'test_helper'

describe "MailGuardTest" do
  before do
    @message = OpenStruct.new(to: "foo@bar.de", subject: "foo")
    MailGuard.new(mail_guard_params).delivering_email(@message)
  end

  describe "#delivering_email" do
    describe "initializes MailGuard without params" do
      let(:mail_guard_params) { {} }

      it "overwrites recipients with default recipient" do
        assert_equal ["default@example.com"], @message.to
        assert_equal "foo", @message.subject
      end
    end

    describe "initializes MailGuard without params" do
      let(:mail_guard_params) { { recipients: ["bar@foo.com"] } }

      it "replaces existing message recipients with provided recipients" do
        assert_equal ["bar@foo.com"], @message.to
        assert_equal "foo", @message.subject
      end
    end

    describe "initializes MailGuard default subject_prefix" do
      let(:mail_guard_params) { { subject_prefix: true } }

      it "adds default subject prefix and replaces recipients" do
        assert_equal ["default@example.com"], @message.to
        assert_equal "[TEST] foo", @message.subject
      end
    end

    describe "initializes MailGuard custom subject_prefix" do
      let(:mail_guard_params) { { subject_prefix: "BLUB" } }

      it "adds custom subject prefix and replaces recipients" do
        assert_equal ["default@example.com"], @message.to
        assert_equal "BLUB foo", @message.subject
      end
    end
  end
end
