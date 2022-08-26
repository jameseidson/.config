/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Misc Tamsyn:size=13"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* gruvbox colors */
static const char dark0_hard[]      = "#1D2021";
// static const char dark0[]           = "#282828";
// static const char dark0_soft[]      = "#32302F";
// static const char dark1[]           = "#3c3836";
// static const char dark2[]           = "#504945";
// static const char dark3[]           = "#665C54";
// static const char dark4[]           = "#7C6F64";

static const char gray_245[]        = "#928374";
// static const char gray_244[]        = "#928374";

static const char light0_hard[]     = "#F9F5D7";
// static const char light0[]          = "#FBF1C7";
// static const char light0_soft[]     = "#F2E5BC";
static const char light1[]          = "#EBDBB2";
// static const char light2[]          = "#D5C4A1";
// static const char light3[]          = "#BDAE93";
// static const char light4[]          = "#A89984";

// static const char bright_red[]      = "#FB4934";
// static const char bright_green[]    = "#B8BB26";
// static const char bright_yellow[]   = "#FABD2F";
// static const char bright_blue[]     = "#83A598";
// static const char bright_purple[]   = "#D3869B";
// static const char bright_aqua[]     = "#8EC07C";
// static const char bright_orange[]   = "#FE8019";

// static const char neutral_red[]     = "#CC241D";
// static const char neutral_green[]   = "#98971A";
// static const char neutral_yellow[]  = "#D79921";
// static const char neutral_blue[]    = "#458588";
// static const char neutral_purple[]  = "#B16286";
// static const char neutral_aqua[]    = "#689D6A";
// static const char neutral_orange[]  = "#D65D0E";

// static const char faded_red[]       = "#9D0006";
static const char faded_green[]     = "#79740E";
static const char faded_yellow[]    = "#B57614";
//static const char faded_blue[]      = "#076678";
//static const char faded_purple[]    = "#8F3F71";
//static const char faded_aqua[]      = "#427B58";
//static const char faded_orange[]    = "#AF3A03";

/* custom colors */
static const char forest_green[]    = "#302F17";

static const char *colors[SchemeLast][2] = {
	/*                        fg            bg       */
	[SchemeNorm]          = { light1,       dark0_hard },
	[SchemeSel]           = { light0_hard,  forest_green },
	[SchemeBorder]        = { light1,       gray_245 },
	[SchemeSelHighlight]  = { faded_yellow, forest_green },
	[SchemeNormHighlight] = { faded_yellow, dark0_hard },
	[SchemeOut]           = { dark0_hard,   dark0_hard },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 5;
