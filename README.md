# BigFantech-Cloud

We automate your infrastructure.
You will have full control of your infrastructure, including Infrastructure as Code (IaC).

To hire, email: `bigfantech@yahoo.com`

# Purpose of this code

> Terraform module

Generate Label output for resources naming conventions, and tags.

This is customised version of `label` module from cloudposse. Courtesy: [cloudposse](https://cloudposse.com)

## Variables

### Required Variables

| Name         | Description                                                                                                    |
| ------------ | -------------------------------------------------------------------------------------------------------------- |
| project_name | ID element. Usually an abbreviation of project or brand name, to help ensure generated IDs are globally unique |

### Optional Variables

```

- context:
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.

    default = {
        enabled             = true
        project_name        = null
        aws_estate          = null
        environment         = null
        stage               = null
        delimiter           = null
        attributes          = []
        tags                = {}
        additional_tag_map  = {}
        regex_replace_chars = null
        label_order         = []
        id_length_limit     = null
        label_key_case      = null
        label_value_case    = null
        descriptor_formats  = {}
        name                = null
        # Note: we have to use [] instead of null for unset lists due to
        # https://github.com/hashicorp/terraform/issues/28137
        # which was not fixed until Terraform 1.0.0,
        # but we want the default to be all the labels in `label_order`
        # and we want users to be able to prevent all tag generation
        # by setting `labels_as_tags` to `[]`, so we need
        # a different sentinel to indicate "default"
        labels_as_tags = ["unset"]
    }

    condition     = lookup(var.context, "label_key_case", null) == null ? true : contains(["lower", "title", "upper"], var.context["label_key_case"])
        error_message = "Allowed values: `lower`, `title`, `upper`.

    condition     = lookup(var.context, "label_value_case", null) == null ? true : contains(["lower", "title", "upper", "none"], var.context["label_value_case"])
        error_message = "Allowed values: `lower`, `title`, `upper`, `none`.

- enabled:
  Set to false to prevent the module from creating any resources

- aws_estate:
  ID element _(Rarely used, not included by default)_. An AWS account identifier

- environment:
  ID element. Usually used for role 'prod', 'staging', 'dev', 'UAT', OR region e.g. 'uw2', 'us-west-2'

- stage:
  ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'

- delimiter:
    Delimiter to be used between ID elements. Set to `""` to use no delimiter at all.
    Default = "-" (hyphen).

- attributes:
    ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,
    in the order they appear in the list. New attributes are appended to the
    end of the list. The elements of the list are joined by the `delimiter`
    and treated as a single ID element.

- labels_as_tags:
    Set of labels (ID elements) to include as tags in the `tags` output.
    Default is to include all labels.

    Tags with empty values will not be included in the `tags` output.
    Set to `[]` to suppress all generated tags.
    **Notes:**
      Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be
      changed in later chained modules. Attempts to change it will be silently ignored.

- tags:
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.

- name:
    Name identifier of the resource.

- additional_tag_map:
    Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.
    This is for some rare cases where resources want additional configuration of tags
    and therefore take a list of maps with tag key, value, and additional configuration.

- label_order:
    The order in which the labels (ID elements) appear in the `id`.
    Defaults to ["project_name", "aws_estate", "environment", "stage", "attributes"].
    You can omit any of the 5 labels, but at least one must be present.

- regex_replace_chars:
    Terraform regular expression (regex) string.
    Characters matching the regex will be removed from the ID elements.
    If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits.

- id_length_limit:
    Limit `id` to this many characters (minimum 6).
    Set to `0` for unlimited length.
    Set to `null` for keep the existing setting, which defaults to `0`.
    Does not affect `id_full`.

    condition     = var.id_length_limit == null ? true : var.id_length_limit >= 6 || var.id_length_limit == 0
    error_message = "The id_length_limit must be >= 6 if supplied (not null), or 0 for unlimited length."

- label_key_case:
    Controls the letter case of the `tags` keys (label names) for tags generated by this module.
    Does not affect keys of tags passed in via the `tags` input.
    Possible values: `lower`, `title`, `upper`.

    Default = "title".

    condition     = var.label_key_case == null ? true : contains(["lower", "title", "upper"], var.label_key_case)
    error_message = "Allowed values: `lower`, `title`, `upper`."

- label_value_case:
    Controls the letter case of ID elements (labels) as included in `id`,
    set as tag values, and output by this module individually.
    Does not affect values of tags passed in via the `tags` input.
    Possible values: `lower`, `title`, `upper` and `none` (no transformation).
    Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.
    Default value: `lower`.

  condition     = var.label_value_case == null ? true : contains(["lower", "title", "upper", "none"], var.label_value_case)
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."

- descriptor_formats:
    Describe additional descriptors to be output in the `descriptors` output map.
    Map of maps. Keys are names of descriptors. Values are maps of the form
    `{
       format = string
       labels = list(string)
    }`
    (Type is `any` so the map values can later be enhanced to provide additional options.)
    `format` is a Terraform format string to be passed to the `format()` function.
    `labels` is a list of labels, in order, to pass to `format()` function.
    Label values will be normalized before being passed to `format()` so they will be
    identical to how they appear in `id`.

    Default is `{}` (`descriptors` output will be empty).

```

## Resources created:

    N/A

## Resources naming convention:

    M/A

# Steps to use the module

1. Copy `context.tf` file from https://github.com/bigfantech-cloud/terraform-null-label/blob/main/exports/ and place it along with your Terraform configs.

2. Start refering to the null-label outputs in your Terrafrom config.

Example:

```
provider "aws {
  region = "us-east-1"
}

module "main-vpc" {
  source      = "bigfantech-cloud/vpc/aws"
  version     = "1.0.0"

  vpc_cidr       = "10.0.0.0/20"
  project_name   = "abc"
  environment    = "dev"
}

resource "aws_s3_bucket" "default" {
  bucket        = module.this.id

  tags = merge(
    module.this.tags,
    {
      "Name" = "${module.this.id}"
    },
  )
}

```

## OUTPUTS

```
- id:
    Disambiguated ID string restricted to `id_length_limit` characters in total

- id_full:
    ID string not restricted in length

- enabled:
    True if module is enabled, false otherwise

- project_name:
    Normalized project_name

- aws_estate:
    Normalized aws_estate

- environment:
    Normalized environment

- stage:
    Normalized stage

- delimiter:
    Delimiter between `project_name`, `aws_estate`, `environment`, `stage`, and `attributes`

- attributes:
    List of attributes

- tags:
    Normalized Tag map

- additional_tag_map:
    The merged additional_tag_map

- label_order:
    The naming order actually used to create the ID

- regex_replace_chars:
    The regex_replace_chars actually used to create the ID

- id_length_limit:
    The id_length_limit actually used to create the ID, with `0` meaning unlimited

- tags_as_list_of_maps:
    This is a list with one map for each `tag`. Each map contains the tag `key`,
    `value`, and contents of `var.additional_tag_map`. Used in the rare cases
    where resources need additional configuration information for each tag.

- descriptors:
    "Map of descriptors as configured by `descriptor_formats`

- normalized_context:
    Normalized context of this module

- context:
    Merged but otherwise unmodified input to this module, to be used as context input to other modules.
    Note: this version will have null values as defaults, not the values actually used as defaults.

```
