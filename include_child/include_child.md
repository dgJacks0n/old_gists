## Issue
I had several R scripts (script1.R, script2.R) that I wanted to include in a single Rmarkdown report.
The individual scripts already generated their own plots, tables, etc.; I wanted to have those appear in the final report.  
To make things trickier, the child scripts were in a code/ subdirectory and my report was in a different subdirectory (relative
to the project home). 
The `source()` command would run the script, but not capture the output.
I knew that `spin_child()` should do this - but getting it to work proved trickier than I thought.

## Solution
I could only get `spin_child` to work as an inline R expression:
```
run my child: `r spin_child("../code/script1.R")`
```
This ran the code and incorporated the output and source in my final report as desired.

Note: I like to put my code at the end of my reports; the child code isn't set into a separate block so I had to add comments at the beginning and end.

## Failures
The following didn't work, even though I thought they should

1. Calling `spin_child()` from inside a chunk:  
    ```
              {r run_child}
                  spin_child("../code/script1.R")
     ```
        
        This gave a 'cannot open the connection error'.  Sourcing the same path in the same chunk worked, so I knew it wasn't a path issue...
2. Setting the `child` option in the chunk header:  
    ```
         { r run_child child = "../code/script1.R"}
    ```
      
    This also gave a 'cannot open the connection' error.
    