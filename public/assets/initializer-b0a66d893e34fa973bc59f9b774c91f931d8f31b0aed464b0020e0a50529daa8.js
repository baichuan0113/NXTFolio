const pageAccessedByReload=window.performance.navigation&&1===window.performance.navigation.type||window.performance.getEntriesByType("navigation").map(e=>e.type).includes("reload");1==pageAccessedByReload&&(console.log("I am initializer"),localStorage.setItem("buttonpressed","false"));