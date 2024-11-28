module Authorization::Helper
  def is_doctor_is_worker?(doctor_id)
    DoctorCenter.find_by(doctor_id: doctor_id, role: 'worker').present? ? true : false
  end

  def is_doctor_is_admin?(doctor_id)
    DoctorCenter.find_by(doctor_id: doctor_id, role: 'admin').present? ? true : false
  end

  def is_doctor_admin_for_center?(doctor_id, center_id)
    Center::IsDoctorAdminService.new(current_doctor_id: doctor_id, center_id: center_id).call
  end

  def is_child_in_center?(child_id, center_id)
    Center::HasChildService.new(child_id: child_id, center_id: center_id).call
  end

  def is_doctor_role_in_center?(doctor_id, center_id, roles = %w[admin worker])
    Center::FindDoctorByRoleService.new(current_doctor_id: doctor_id, center_id: center_id, role: roles).call
  end

  def is_doctor_has_child_in_center?(doctor_id, child_id, center_id)
    Child::HasDoctorInCenterService.new(doctor_id: doctor_id, child_id: child_id, center_id: center_id).call
  end

  def is_doctor_in_session?(doctor_id, session_id)
    Session::HasDoctorService.new(doctor_id: doctor_id, session_id: session_id).call
  end
end
