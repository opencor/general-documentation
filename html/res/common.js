function month(month) {
    switch (month) {
    case 1:
        return "January";
    case 2:
        return "February";
    case 3:
        return "March";
    case 4:
        return "April";
    case 5:
        return "May";
    case 6:
        return "June";
    case 7:
        return "July";
    case 8:
        return "August";
    case 9:
        return "September";
    case 10:
        return "October";
    case 11:
        return "November";
    case 12:
        return "December";
    default:
        return "???";
    }
}

function copyright(relativePath) {
    let date = new Date();
    let startingYear = 2011;
    let currentYear = date.getFullYear();

    document.write("<div class=\"copyright\">\n");
    document.write("    <div class=\"left\">\n");
    document.write("        Copyright "+startingYear+((currentYear == startingYear)?"":"-"+currentYear)+"\n");
    document.write("    </div>\n");
    document.write("    <div class=\"center\">\n");
    document.write("        <a class=\"copyright\" href=\"https://twitter.com/TeamOpenCOR/\"><img class=\"twitter\" src=\""+relativePath+"/res/pics/twitter.png\" width=30 height=30></a>\n");
    document.write("    </div>\n");
    document.write("    <div class=\"right\">\n");
    document.write("        <a class=\"copyright\" href=\"https://virtualrat.org/\"><img class=\"vpr\" src=\""+relativePath+"/res/pics/vpr.png\" width=60 height=18></a>\n");
    document.write("    </div>\n");
    document.write("</div>\n");
}
