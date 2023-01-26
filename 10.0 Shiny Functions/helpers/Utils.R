SelectInput <- function(id, label, value){
  numericInput(id, label, value)
}


box_plot <- function(data, title="No title"){
  boxplot(data, main=title)
} 
## ... to allow any other parameters.
value_box <- function(class="",style="",title="No title", value=0,...){
  div(
    class=class, style=style,
    h4(title),
    div(
      p(value)
    )
  )
}