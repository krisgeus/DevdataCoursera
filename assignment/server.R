library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  f1 = function(x){
    return(sin(x*10)/10 + 2^(-(x)^2))
  }
  
  f2 = function(x){
    return(sin(x*10))
  }
  
  f3 = function(x){
    return( 5*sin(x)/(x^2+1)^2 )
  }
  
  
  newsample = function(f, bestxvals, num, xrange, globalxmin, globalxmax){
    xvals = rep(bestxvals,num) + runif(length(bestxvals)*num,-xrange,xrange)
    xvals = sapply(xvals, function(x){ return(max(min(x, globalxmax), globalxmin)) } ) 
    yvals = sapply(xvals, f)
    newdf = data.frame(x = xvals, y = yvals)
    return(newdf)
  }
  
  runsampler = function(f, t){
    minx = -4
    maxx = 4
    stepsize = 0.02
    sample_size = input$sample_size
    numiters = input$num_iterations
    
    xvals = seq(minx,maxx,stepsize)
    yvals = sapply(xvals, f)
    distdf = data.frame( x=xvals, y= yvals)
    
    samplesx = runif(sample_size, minx, maxx)
    samplesy = sapply(samplesx, f)
    sampledf = data.frame( x=samplesx, y=samplesy)
    
    p = ggplot() + geom_line(data=distdf, aes(x,y)) + ggtitle(t)
    
    for( i in 1:numiters ){
      p = p + geom_point(data=sampledf, aes(x,y), colour="steelblue", size=2)  
      bestof   = sampledf[ order(-sampledf$y), ][1:round(nrow(sampledf)/5),]
      sampledf = newsample(f, bestof$x, 5, (maxx - minx)/(numiters+1), minx, maxx )
    }
    
    p = p + geom_point(data=sampledf, aes(x,y), colour="red", size=3, alpha=1)  
    p = p + geom_point(data=sampledf[ which.max(sampledf$y), ], aes(x,y), colour="green", size=3)
    p
  }
  
  output$distPlot1 <- renderPlot({
    runsampler(f1, expression(sin(10*x)/10 + 2^(-(x)^2)))
  })
  output$distPlot2 <- renderPlot({
    runsampler(f2, expression(sin(10*x)))
  })
  output$distPlot3 <- renderPlot({
    runsampler(f3, expression(5*sin(x)/(x^2+1)^2 ))
  })
  
})