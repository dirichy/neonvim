;;extends
(source_file
  .(_) @_start
  (_) @_end
  .
  (generic_environment
    begin: (begin
      name: (curly_group_text
              text:(text) @env_name))) 
  (#eq? @env_name "document")
  (#make-range! "fold" @_start @_end))
