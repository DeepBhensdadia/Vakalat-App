class clsCourse {

  String? law_college_courses_id;
  String? academic_year_id;
  String? degree_id;
  String? subject_id;
  String? course_name;
  String? course_description;
  String? is_active;
  String? is_delete;
  String? created_by;
  String? created_datetime;
  String? updated_by;
  String? updated_datetime;
  String? academic_year;
  String? degree_name;
  String? degree_type;
  String? description;

  clsCourse(
      {this.law_college_courses_id,
        this.academic_year_id,
        this.degree_id,
        this.subject_id,
        this.course_name,
        this.course_description,
        this.is_active,
        this.is_delete,
        this.created_by,
        this.created_datetime,
        this.updated_by,
        this.updated_datetime,
        this.academic_year,
        this.degree_name,
        this.degree_type,
        this.description,});

  // This model is sub model of Login for fetching data object

  factory clsCourse.fromJson(Map<String, dynamic> json) {
    return clsCourse(
      law_college_courses_id: json['law_college_courses_id'] == null ? "" : json['law_college_courses_id'] as String?,
      academic_year_id: json['academic_year_id'] == null ? "" : json['academic_year_id'] as String?,
      degree_id: json['degree_id'] == null ? "" : json['degree_id'] as String?,
      subject_id: json['subject_id'] == null ? "" : json['subject_id'] as String?,
      course_name: json['course_name'] == null ? "" : json['course_name'] as String?,
      course_description: json['course_description'] == null ? "" : json['course_description'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_datetime: json['created_datetime'] == null ? "" : json['created_datetime'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_datetime: json['updated_datetime'] == null ? "" : json['updated_datetime'] as String?,
      academic_year: json['academic_year'] == null ? "" : json['academic_year'] as String?,
      degree_name: json['degree_name'] == null ? "" : json['degree_name'] as String?,
      degree_type: json['degree_type'] == null ? "" : json['degree_type'] as String?,
      description: json['description'] == null ? "" : json['description'] as String?,
    );
  }

}
