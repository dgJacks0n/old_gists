A nice trick to toggle show/hide for outuput in a Rmarkdown html document (analogous to showing/hiding code):
```
<button class="btn btn-primary" data-toggle="collapse" data-target="#SessionInfo"> Show/Hide </button>  
<div id="SessionInfo" class="collapse">  

    ```{r}
    plot(mtcars$disp, mtcars$mpg)
    ```

</div>
```

Note- I'd like to see if I can format the button to look more like the code buttons