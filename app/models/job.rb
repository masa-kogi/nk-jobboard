class Job < ApplicationRecord
  belongs_to :category
  belongs_to :department
  belongs_to :work_location

  has_many :job_contact_person_maps, dependent: :destroy
  has_many :contact_persons, through: :job_contact_person_maps, source: :contact_person
  has_many :job_statuses, through: :job_status_maps
  has_many :job_status_maps, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :applicants, through: :job_applications, source: :applicant

  attr_accessor :contact_person_ids
  attr_accessor :job_status_id, :previous_job_status_id
  # attr_accessor :contact_person_ids

  with_options presence: true do
     validates :title
     validates :job_description
     validates :application_requirement
  end

  validate :at_least_one_contact_person
  validate :status_must_be_selected

  after_create :create_job_status_map
  after_update :create_job_status_map, if: :job_status_id_changed?

  def current_status
    self.job_status_maps.order(created_at: :desc).first&.job_status
  end

  def update_contact_persons(contact_person_ids)
    # 現在の連絡先担当者のIDを取得
    current_contact_person_ids = self.job_contact_person_maps.pluck(:contact_person_id)

    # 新しく追加される連絡先担当者のIDを取得
    new_contact_persons = Array(contact_person_ids).map(&:to_i) - current_contact_person_ids

    # 新しい連絡先担当者を追加
    new_contact_persons.each do |contact_person_id|
      self.job_contact_person_maps.create!(contact_person_id: contact_person_id)
    end

    # 削除される連絡先担当者のIDを取得
    removed_contact_persons = current_contact_person_ids - Array(contact_person_ids).map(&:to_i)

    # 不要になった連絡先担当者を削除
    removed_contact_persons.each do |contact_person_id|
      self.job_contact_person_maps.where(contact_person_id: contact_person_id).destroy_all
    end
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "contact_person", "department", "job_contact_person_maps", "job_status_maps", "job_statuses", "recruiters", "work_location"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["application_requirement", "category_id", "created_at", "department_id", "global_search", "id", "job_description", "title", "updated_at", "work_location_id"]
  end

  ransack_alias :global_search, :title_or_job_description_or_application_requirement

  private

  def create_job_status_map
    job_status_map = self.job_status_maps.build(job_status_id: job_status_id)
    unless job_status_map.save
      Rails.logger.error("Failed to save job_status_map for job_id: #{self.id} with error: #{job_status_map.errors.full_messages.join(", ")}")
    end
    Rails.logger.info("After attempting to save: job_status_map valid?: #{job_status_map.valid?}, errors: #{job_status_map.errors.full_messages.join(", ")}")
  end

  def job_status_id_changed?
    job_status_id != previous_job_status_id
  end

  def at_least_one_contact_person
    if contact_person_ids.blank? || contact_person_ids.all?(&:blank?)
      errors.add(:contact_person, "を最低1人選択してください")
    end
  end

  def status_must_be_selected
    if job_status_id.blank?
      errors.add(:job_status_id, "を選択してください")
    end
  end

end
