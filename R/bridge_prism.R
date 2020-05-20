model_run<-function(model_input = NULL)
{

  input<-unflatten_list(model_input)

  results <- predictcvd         (gender               =model_input$gender,
                                 age                  =model_input$age,
                                 Tchol                =model_input$Tchol,
                                 HDLchol              =model_input$HDLchol,
                                 SBP                  =model_input$SBP,
                                 DBP                  =model_input$DBP,
                                 diabetes             =model_input$diabetes,
                                 smoker               =model_input$smoker,
                                 ECG_LVH              =model_input$ECG_LVH,
                                 t                    =model_input$t)

  return(as.list(results))
}


get_default_input <- function() {

  model_input <- list(gender               =1,
                      age                  =33,
                      Tchol                =230,
                      HDLchol              =48,
                      SBP                  =135,
                      DBP                  =88,
                      diabetes             =1,
                      smoker               =1,
                      ECG_LVH              =0,
                      t                    =10)

  return((flatten_list(model_input)))
}


#Gets a hierarchical named list and flattens it; updating names accordingly
flatten_list<-function(lst,prefix="")
{
  if(is.null(lst)) return(lst)
  out<-list()
  if(length(lst)==0)
  {
    out[prefix]<-NULL
    return(out)
  }

  for(i in 1:length(lst))
  {
    nm<-names(lst[i])

    message(nm)

    if(prefix!="")  nm<-paste(prefix,nm,sep=".")

    if(is.list(lst[[i]]))
      out<-c(out,flatten_list(lst[[i]],nm))
    else
    {
      out[nm]<-lst[i]
    }
  }
  return(out)
}



#Gets a hierarchical named list and flattens it; updating names accordingly
unflatten_list<-function(lst)
{
  if(is.null(lst)) return(lst)
  out<-list()

  nms<-names(lst)

  for(nm in nms)
  {
    path<-paste(strsplit(nm,'.',fixed=T)[[1]],sep="$")
    eval(parse(text=paste("out$",paste(path,collapse="$"),"<-lst[[nm]]",sep="")))
  }

  return(out)
}
