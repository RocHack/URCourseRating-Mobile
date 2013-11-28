//
//  DepsViewContoller.m
//
//  Created by Praneet Tata on 7/19/13.
//
//

#import "DepsViewContoller.h"
#import "CoursesViewController.h"

@interface DepsViewContoller ()

@property (nonatomic,retain) NSMutableArray *deps;

@end

@implementation DepsViewContoller

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        _tableView.dataSource = self;
        _tableView.delegate = (id)self;
        [self.view addSubview:self.tableView];



    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Departments";
    // Do any additional setup after loading the view from its nib.
    self.deps = [[NSMutableArray alloc] initWithObjects:@"AAS - African & African-American Studies",@"ACC - Accounting",@"ACM - Accompanying",
            @"ACY - Accompanying Class",
            @"AEC - Applied Economics",
            @"AH - Art & Art History-Art History",
            @"AH - Art History",
            @"ALC - Arts Leadership Curriculum",
            @"AME - Audio Music Engineering",
            @"AMS - American Studies",
            @"AMU - Applied Music Lessons: Summer",
            @"ANA - Anatomy",
            @"ANR - Anthropology",
            @"ANT - Anthropology",
            @"APS - Applied Statistics",
            @"ARA - Religion & Classics - Arabic",
            @"ASL - American Sign Language",
            @"AST - Astronomy",
            @"BCH - Biochemistry",
            @"BCS - Brain and Cognitive Sciences",
            @"BIO - Biology",
            @"BME - Biomedical Engineering",
            @"BPH - Biophysics",
            @"BPP - Business Environment & Public Policies",
            @"BRN - BRN",
            @"BSI - Behavioral Science in Industry",
            @"BSN - Bassoon",
            @"BST - Biostatistics",
            @"CAS - College of Arts & Science",
            @"CED - CED",
            @"CGR - Religion & Classics - Classical Greek",
            @"CHB - Chamber Music",
            @"CHE - Chemical Engineering",
            @"CHI - Modern Languages & Cultures - Chinese",
            @"CHM - Chemistry",
            @"CIS - Computers & Information Systems",
            @"CL - Clarinet",
            @"CLA - Religion & Classics - Classical Studies",
            @"CLT - Modern Languages & Cultures - Comparative Literature",
            @"CMP - Composition",
            @"CND - Conducting",
            @"CSC - Computer Science",
            @"CSP - Clinical and Social Sciences in Psychology",
            @"CVS - Cardiovascular Biology & Disease",
            @"CVS - Center for Visual Science",
            @"DAN - Dance",
            @"DBL - Double Bass",
            @"DGD - DGD Courses",
            @"DMS - Digital Media Studies",
            @"DOM - Oral & Maxillofacial Surgery",
            @"DOR - Orthodontics",
            @"DPD - Pediatric Dentistry",
            @"DPR - Periodontics",
            @"DPS - Prosthodintics",
            @"DTR - 2yr Training Pediatric Dentistry",
            @"EAS - Engineering and Applied Sciences",
            @"ECE - Electrical and Computer Engineering",
            @"ECM - Electronic Commerce",
            @"ECO - Economics",
            @"ED - ED Courses",
            @"EDE - EDE Courses",
            @"EDF - EDF Courses",
            @"EDU - EDU Courses",
            @"EES - Earth & Environmental Science",
            @"EIC - Eastman Initiatives Curriculum",
            @"ENG - English",
            @"ENS - Ensemble",
            @"ENT - Entrepreneurship",
            @"ERG - Alternative Energy",
            @"ESL - English as a Second Language",
            @"ESM - Eastman School of Music",
            @"ETH - Ethnomusicology",
            @"EUP - Euphonium",
            @"EXP - Executive Development Program",
            @"FIN - Finance",
            @"FL - Flute",
            @"FMS - Film and Media Studies",
            @"FR - French",
            @"FR - Modern Languages & Cultures - French",
            @"FS - Film Studies",
            @"FWS - Freshman Writing Seminar",
            @"GBA - General Business Administration",
            @"GEN - Genetics",
            @"GER - German",
            @"GER - Modern Languages & Cultures - German",
            @"GTC - Guitar Class",
            @"GTR - Guitar",
            @"HEB - Religion & Classics - Hebrew",
            @"HIS - History",
            @"HLS - Health and Society",
            @"HPC - Harpsichord",
            @"HRN - Horn",
            @"HRP - Harp",
            @"HSE - HSE Courses",
            @"HSM - Health Science Management",
            @"HUM - Humanities",
            @"IND - Interdepartmental",
            @"INS - Institutes",
            @"IR - International Relations",
            @"IT - Italian",
            @"IT - Modern Languages & Cultures - Italian",
            @"JAZ - Jazz Lessons",
            @"JCM - Jazz Study & Contemporary Media",
            @"JPN - Modern Languages & Cultures - Japanese",
            @"JST - Judaic Studies",
            @"KBD - Keyboard",
            @"LAM - Lab Animal Medicine",
            @"LAT - Religion & Classics - Latin",
            @"LAW - Business Law",
            @"LIN - Linguistics",
            @"LTS - Literary Translation Studies",
            @"LUT - Lute",
            @"MBI - Microbiology",
            @"ME - Mechanical Engineering",
            @"MED - Medicine",
            @"MGC - Managerial Communications",
            @"MHB - Medical Humanities and Bioethics",
            @"MHS - Music History",
            @"MIF - Medical Informatics",
            @"MKT - Marketing",
            @"MSC - Materials Science",
            @"MSM - Management Science Models",
            @"MTH - Mathematics",
            @"MUE - Music Education",
            @"MUR - Music",
            @"MUY - Musicology",
            @"NAV - Naval Science",
            @"NLX - Leadership in Health Care Systems",
            @"NSC - Neuroscience",
            @"NSG - Center for Lifelong Learning",
            @"NUR - Nursing",
            @"OB - Oboe",
            @"OMG - Operations Management",
            @"OP - Opera",
            @"OPT - Optics",
            @"ORB - ORB Courses",
            @"ORC - Orchestration",
            @"ORG - Organ",
            @"PA - Piano",
            @"PCL - Piano Class",
            @"PEC - Wallis Institute of Political Economics",
            @"PED - Pedagogy",
            @"PH - Public Health",
            @"PHL - Philosophy",
            @"PHP - Pharmacology & Physiology",
            @"PHY - Physics",
            @"PIC - Piccolo",
            @"PM - Preventive Medicine",
            @"POL - Modern Languages & Cultures - Polish",
            @"PRC - Percussion",
            @"PRF - Performance",
            @"PSC - Political Science",
            @"PSI - Psychiatry",
            @"PSY - Psychology",
            @"PTH - Pathology",
            @"RAD - Radiology",
            @"REL - Religion and Classics",
            @"RST - Modern Languages & Cultures - Russian Studies",
            @"RUS - Modern Languages & Cultures - Russian",
            @"SA - Art & Art History-Studio Arts",
            @"SAB - Study Abroad",
            @"SAX - Saxophone",
            @"SKT - Religion & Classics - Sanskrit",
            @"SMU - Sacred Music",
            @"SOC - Sociology",
            @"SP - Modern Languages & Cultures - Spanish",
            @"STR - Managerial Economics",
            @"STR - Strings",
            @"STT - Statistics",
            @"TBA - Tuba",
            @"TBN - Trombone",
            @"TCS - TEAM Computer Science",
            @"TEB - TEAM Biomedical Engineering",
            @"TEC - TEAM Chemical Engineering",
            @"TEE - TEAM Electrical Engineering",
            @"TEM - New Department/Subject",
            @"TEM - Technical Entrepreneurship Management",
            @"TEO - TEAM Optics",
            @"TH - Theory",
            @"TME - TEAM Mechanical Engineering",
            @"TMJ - Temporomandibular Jnt Disrdr",
            @"TOX - Toxicology",
            @"TPT - Trumpet",
            @"VCE - Voice",
            @"VCL - Violoncello",
            @"VLA - Viola",
            @"VLN - Violin",
            @"VSR - Visiting Student In Residence",
            @"WLN - Wellness",
            @"WRT - Writing Program",
            @"WST - Women's Studies",nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.deps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    
    NSString *department = [self.deps objectAtIndex:indexPath.row];
    cell.textLabel.text = department;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:17];
    return cell;
}



#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *sname = [[self.deps objectAtIndex:indexPath.row] substringToIndex:3];
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"sname" equalTo:sname];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if(results.count != 0){
            CoursesViewController *course = [[CoursesViewController alloc] initWithNibName:@"CoursesViewController" bundle:nil cname:sname];
            course.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:course animated:YES];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Courses found!" message:@"The department you have selected does not have any course reviews" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
        
     
    }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
