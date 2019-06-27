output kops_iam_instance_profile_name {
    value = "${aws_iam_instance_profile.kops_profile.name}"
}