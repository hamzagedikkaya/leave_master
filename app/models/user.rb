# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :two_factor_authenticatable, otp_secret_encryption_key: ENV.fetch("OTP_SECRET_KEY")

  has_one_attached :profile_image

  # Validations
  validates :name_surname, presence: { message: I18n.t("errors.messages.name_surname_blank") },
                           format: { with: /\A[a-zA-ZşŞıİçÇğĞöÖüÜ\s]+\z/, message: I18n.t("errors.messages.name_surname_invalid") }

  validates :gsm, presence: { message: I18n.t("errors.messages.gsm_invalid") },
                  numericality: { only_integer: true, message: I18n.t("errors.messages.gsm_invalid") }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validate :acceptable_image

  validates :locale, inclusion: {
    in: %w[en hr mk kk lv de fr ka ru kz],
    message: lambda { |_object, data|
      I18n.t("models.user.locale_invalid", value: data[:value])
    }
  }, allow_blank: true

  def generate_otp_secret
    self.otp_secret = ROTP::Base32.random
    save!
  end

  def verify_otp(otp_code)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(otp_code)
  end

  def generate_qr_code
    self.otp_secret ||= ROTP::Base32.random
    totp = ROTP::TOTP.new(otp_secret)
    totp.provisioning_uri(email)
  end

  private

  def acceptable_image
    return unless profile_image.attached?

    errors.add(:profile_image, I18n.t("errors.messages.profile_image_too_large")) unless profile_image.byte_size <= 10.megabytes

    acceptable_types = ["image/jpg", "image/jpeg", "image/png"]
    return if acceptable_types.include?(profile_image.content_type)

    errors.add(:profile_image, I18n.t("errors.messages.profile_image_invalid_format"))
  end
end
