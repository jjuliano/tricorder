# tricorder
A Domain-Specific Language for Star Trek API (http://stapi.co)

# Installation

```
gem install tricorder
```

# Usage

## CLI
Once installed, you can run the command `tricorder`.

To display all the available options for search type `tricorder help` or `tricorder help search`.

To search the API, invoke the `search <keyword>` command, which searches all databases by default.

```
tricorder search Uhura --api-key=ABC123
```

There are only 250 queries for hour for non-authenticated users, to specify the API Key, add the `--api-key=APIKEY` set the API Key on each query.

To search only specific database, use the `--database <database name>` to specify the database, for example

```
tricorder search Uhura --database character book
```

To print extra details, add the `--print-details` in the command, for example

```
tricorder search uhura --database character --print-details
```

To scope on a specific detail, add the `--print-info <scope>` scoping a result

```
$ tricorder search Uhura --database character --print-only-once --print-info=characterSpecies name
Human
```

## Domain Specific Language
Here's an example of using tricorder programmatically via it's own DSL syntax,

```
require 'tricorder'
include Tricorder

tricorder do
  no_logging
  api_key('MYAPIKEY')
  set_subject('Uhura')
  search_locations(:character)
  print_only_once
  print_info(['characterSpecies', 'name'])
end
```

It set no_logging, set's the API key, set the subject to 'Uhura', set the database to 'character', scope to 'characterSpecies name' and print only once.