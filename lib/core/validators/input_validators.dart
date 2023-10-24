class Validators {
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
  static const String PASSWORD_REGEX =
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$";
  static const String NAME_REGEX = r"/(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$)/";
  static const String LINKEDIN_REGEX =
      r"((https?:\/\/)?((www|\w\w)\.)?linkedin\.com\/)((([\w]{2,3})?)|([^\/]+\/(([\w|\d-&#?=])+\/?){1,}))$";
  static const String PHONE_REGEX = r"[0-9]{9}";
  static String? validateEmail(String? email) {
    return (RegExp(EMAIL_REGEX).hasMatch(email!))
        ? null
        : "Invalid email address.";
  }

  static String? validateLinkedin(String? linkedIn) {
    return (RegExp(LINKEDIN_REGEX).hasMatch(linkedIn!))
        ? null
        : "Invalid LinkedIn address.";
  }

  static String? validatePassword(String? password) {
    print("wwww $password");
    if (password!.isEmpty) {
      return "please enter your password";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters";
    } else if (RegExp(PASSWORD_REGEX).hasMatch(password!) != false) {
      return "Password can only contain a number and letter";
    } else {
      return null;
    }
  }

  static String? validateName(String? name, String label) {
    if (name == null || name.isEmpty) {
      return '$label is required';
    }
    return (RegExp(NAME_REGEX).hasMatch(name)) ? "Invalid $label." : null;
  }

  static String? validatePhone(String? phone) {
    return (RegExp(PHONE_REGEX).hasMatch(phone!))
        ? null
        : "last 9 digits are required";
  }

  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'title is required';
    }
    return null;
  }

  static String? validateBlogTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Blog title is required';
    }
    return null;
  }

  static String? validateContent(String? content, String label) {
    if (content == null || content.isEmpty) {
      return '$label is required';
    }
    return null;
  }

  static String? validatePlacementType(String? placementType) {
    if (placementType == null || placementType.isEmpty) {
      return 'placement type is required';
    }
    return null;
  }

  static String? validateRoleCompany(String? roleCompany) {
    if (roleCompany == null || roleCompany.isEmpty) {
      return 'Role at company is required';
    }
    return null;
  }

  static String? validatePlace(String? place) {
    if (place == null || place.isEmpty) {
      return 'Place is required';
    }
    return null;
  }

  static String? validateCompany(String? company) {
    if (company == null || company.isEmpty) {
      return 'Company is required';
    }
    return null;
  }

  static String? validateDescription(String? description) {
    if (description == null || description.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  static String? validateCategory(String? category, String label) {
    if (category == null || category.isEmpty) {
      return 'must select $label';
    }
    return null;
  }
}
