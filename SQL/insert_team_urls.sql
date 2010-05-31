
ALTER TABLE display_names ADD COLUMN url VARCHAR(255);

UPDATE display_names SET url='http://wwww.nba.com/hawks/' WHERE full_name LIKE 'Atlanta Hawks';
UPDATE display_names SET url='http://wwww.nba.com/celtics/' WHERE full_name LIKE 'Boston Celtics';
UPDATE display_names SET url='http://wwww.nba.com/bobcats/' WHERE full_name LIKE 'Charlotte Bobcats';
UPDATE display_names SET url='http://wwww.nba.com/bulls/' WHERE full_name LIKE 'Chicago Bulls';
UPDATE display_names SET url='http://wwww.nba.com/cavaliers/' WHERE full_name LIKE 'Cleveland Cavaliers';
UPDATE display_names SET url='http://wwww.nba.com/mavericks/' WHERE full_name LIKE 'Dallas Mavericks';
UPDATE display_names SET url='http://wwww.nba.com/nuggets/' WHERE full_name LIKE 'Denver Nuggets';
UPDATE display_names SET url='http://wwww.nba.com/pistons/' WHERE full_name LIKE 'Detroit Pistons';
UPDATE display_names SET url='http://wwww.nba.com/warriors/' WHERE full_name LIKE 'Golden State Warriors';
UPDATE display_names SET url='http://wwww.nba.com/rockets/' WHERE full_name LIKE 'Houston Rockets';
UPDATE display_names SET url='http://wwww.nba.com/pacers/' WHERE full_name LIKE 'Indiana Pacers';
UPDATE display_names SET url='http://wwww.nba.com/clippers/' WHERE full_name LIKE 'Los Angeles Clippers';
UPDATE display_names SET url='http://wwww.nba.com/lakers/' WHERE full_name LIKE 'Los Angeles Lakers';
UPDATE display_names SET url='http://wwww.nba.com/grizzlies/' WHERE full_name LIKE 'Memphis Grizzlies';
UPDATE display_names SET url='http://wwww.nba.com/heat/' WHERE full_name LIKE 'Miami Heat';
UPDATE display_names SET url='http://wwww.nba.com/bucks/' WHERE full_name LIKE 'Milwaukee Bucks';
UPDATE display_names SET url='http://wwww.nba.com/timberwolves/' WHERE full_name LIKE 'Minnesota Timberwolves';
UPDATE display_names SET url='http://wwww.nba.com/nets/' WHERE full_name LIKE 'New Jersey Nets';
UPDATE display_names SET url='http://wwww.nba.com/hornets/' WHERE full_name LIKE 'New Orleans/Okla City Hornets';
UPDATE display_names SET url='http://wwww.nba.com/knicks/' WHERE full_name LIKE 'New York Knicks';
UPDATE display_names SET url='http://wwww.nba.com/magic/' WHERE full_name LIKE 'Orlando Magic';
UPDATE display_names SET url='http://wwww.nba.com/76ers/' WHERE full_name LIKE 'Philadelphia 76ers';
UPDATE display_names SET url='http://wwww.nba.com/suns/' WHERE full_name LIKE 'Phoenix Suns';
UPDATE display_names SET url='http://wwww.nba.com/blazers/' WHERE full_name LIKE 'Portland Trail Blazers';
UPDATE display_names SET url='http://wwww.nba.com/kings/' WHERE full_name LIKE 'Sacramento Kings';
UPDATE display_names SET url='http://wwww.nba.com/spurs/' WHERE full_name LIKE 'San Antonio Spurs';
UPDATE display_names SET url='http://wwww.nba.com/supersonics/' WHERE full_name LIKE 'Seattle SuperSonics';
UPDATE display_names SET url='http://wwww.nba.com/raptors/' WHERE full_name LIKE 'Toronto Raptors';
UPDATE display_names SET url='http://wwww.nba.com/jazz/' WHERE full_name LIKE 'Utah Jazz';
UPDATE display_names SET url='http://wwww.nba.com/wizards/' WHERE full_name LIKE 'Washington Wizards';

UPDATE display_names SET url='http://wwww.baltimoreravens.com/'
                    WHERE full_name LIKE 'Baltimore Ravens';
UPDATE display_names SET url='http://wwww.buffalobills.com/'
                    WHERE full_name LIKE 'Buffalo Bills';
UPDATE display_names SET url='http://wwww.bengals.com/'
                    WHERE full_name LIKE 'Cincinnati Bengals';
UPDATE display_names SET url='http://wwww.clevelandbrowns.com/'
                    WHERE full_name LIKE 'Cleveland Browns';
UPDATE display_names SET url='http://wwww.denverbroncos.com/'
                    WHERE full_name LIKE 'Denver Broncos';
UPDATE display_names SET url='http://wwww.houstontexans.com/'
                    WHERE full_name LIKE 'Houston Texans';
UPDATE display_names SET url='http://wwww.colts.com/'
                    WHERE full_name LIKE 'Indianapolis Colts';
UPDATE display_names SET url='http://wwww.jaguars.com/'
                    WHERE full_name LIKE 'Jacksonville Jaguars';
UPDATE display_names SET url='http://wwww.kcchiefs.com/'
                    WHERE full_name LIKE 'Kansas City Chiefs';
UPDATE display_names SET url='http://wwww.miamidolphins.com/'
                    WHERE full_name LIKE 'Miami Dolphins';
UPDATE display_names SET url='http://wwww.patriots.com/'
                    WHERE full_name LIKE 'New England Patriots';
UPDATE display_names SET url='http://wwww.newyorkjets.com/'
                    WHERE full_name LIKE 'New York Jets';
UPDATE display_names SET url='http://wwww.raiders.com/'
                    WHERE full_name LIKE 'Oakland Raiders';
UPDATE display_names SET url='http://wwww.steelers.com/'
                    WHERE full_name LIKE 'Pittsburgh Steelers';
UPDATE display_names SET url='http://wwww.chargers.com/'
                    WHERE full_name LIKE 'San Diego Chargers';
UPDATE display_names SET url='http://wwww.titansonline.com/'
                    WHERE full_name LIKE 'Tennesee Titans';
UPDATE display_names SET url='http://wwww.azfalcons.com/'
                    WHERE full_name LIKE 'Arizona Falcons';
UPDATE display_names SET url='http://wwww.atlantafalcons.com/'
                    WHERE full_name LIKE 'Atlanta Falcons';
UPDATE display_names SET url='http://wwww.panthers.com/'
                    WHERE full_name LIKE 'Carolina Panthers';
UPDATE display_names SET url='http://wwww.chicagobears.com/'
                    WHERE full_name LIKE 'Chicago Bears';
UPDATE display_names SET url='http://wwww.dallascowboys.com/'
                    WHERE full_name LIKE 'Dallas Cowboys';
UPDATE display_names SET url='http://wwww.detroitlions.com/'
                    WHERE full_name LIKE 'Detroit Lions';
UPDATE display_names SET url='http://wwww.packers.com/'
                    WHERE full_name LIKE 'Green Bay Packers';
UPDATE display_names SET url='http://wwww.vikings.com/'
                    WHERE full_name LIKE 'Minnesota Vikings';
UPDATE display_names SET url='http://wwww.neworleanssaints.com/'
                    WHERE full_name LIKE 'New Orleans Saints';
UPDATE display_names SET url='http://wwww.giants.com/'
                    WHERE full_name LIKE 'New York Giants';
UPDATE display_names SET url='http://wwww.philadelphiaeagles.com/'
                    WHERE full_name LIKE 'Philadelphia Eagles';
UPDATE display_names SET url='http://wwww.sf49ers.com/'
                    WHERE full_name LIKE 'San Francisco 49ers';
UPDATE display_names SET url='http://wwww.seahawks.com/'
                    WHERE full_name LIKE 'Seattle Seahawks';
UPDATE display_names SET url='http://wwww.stlouisrams.com/'
                    WHERE full_name LIKE 'St. Louis Rams';
UPDATE display_names SET url='http://wwww.buccaneers.com/'
                    WHERE full_name LIKE 'Tampa Bay Buccaneers';
UPDATE display_names SET url='http://wwww.redskins.com/'
                    WHERE full_name LIKE 'Washington Redskins';
                    
UPDATE display_names SET url='http://mightyducks.nhl.com/' WHERE full_name LIKE 'Anaheim Mighty Ducks';
UPDATE display_names SET url='http://thrashers.nhl.com/' WHERE full_name LIKE 'Atlanta Thrashers';
UPDATE display_names SET url='http://bruins.nhl.com/' WHERE full_name LIKE 'Boston Bruins';
UPDATE display_names SET url='http://sabres.nhl.com/' WHERE full_name LIKE 'Buffalo Sabres';
UPDATE display_names SET url='http://flames.nhl.com/' WHERE full_name LIKE 'Calgary Flames';
UPDATE display_names SET url='http://hurricanes.nhl.com/' WHERE full_name LIKE 'Carolina Hurricanes';
UPDATE display_names SET url='http://blackhawks.nhl.com/' WHERE full_name LIKE 'Chicago Blackhawks';
UPDATE display_names SET url='http://bluejackets.nhl.com/' WHERE full_name LIKE 'Columbus Blue Jackets';
UPDATE display_names SET url='http://avalanche.nhl.com/' WHERE full_name LIKE 'Colorado Avalanche';
UPDATE display_names SET url='http://stars.nhl.com/' WHERE full_name LIKE 'Dallas Stars';
UPDATE display_names SET url='http://redwings.nhl.com/' WHERE full_name LIKE 'Detroit Red Wings';
UPDATE display_names SET url='http://oilers.nhl.com/' WHERE full_name LIKE 'Edmonton Oilers';
UPDATE display_names SET url='http://panthers.nhl.com/' WHERE full_name LIKE 'Florida Panthers';
UPDATE display_names SET url='http://kings.nhl.com/' WHERE full_name LIKE 'Los Angeles Kings';
UPDATE display_names SET url='http://wild.nhl.com/' WHERE full_name LIKE 'Minnesota Wild';
UPDATE display_names SET url='http://canadiens.nhl.com/' WHERE full_name LIKE 'Montreal Canadiens';
UPDATE display_names SET url='http://predators.nhl.com/' WHERE full_name LIKE 'Nashville Predators';
UPDATE display_names SET url='http://devils.nhl.com/' WHERE full_name LIKE 'New Jersey Devils';
UPDATE display_names SET url='http://islanders.nhl.com/' WHERE full_name LIKE 'New York Islanders';
UPDATE display_names SET url='http://rangers.nhl.com/' WHERE full_name LIKE 'New York Rangers';
UPDATE display_names SET url='http://senators.nhl.com/' WHERE full_name LIKE 'Ottawa Senators';
UPDATE display_names SET url='http://flyers.nhl.com/' WHERE full_name LIKE 'Philadelphia Flyers';
UPDATE display_names SET url='http://coyotes.nhl.com/' WHERE full_name LIKE 'Phoenix Coyotes';
UPDATE display_names SET url='http://penguins.nhl.com/' WHERE full_name LIKE 'Pittsburgh Penguins';
UPDATE display_names SET url='http://sharks.nhl.com/' WHERE full_name LIKE 'San Jose Sharks';
UPDATE display_names SET url='http://blues.nhl.com/' WHERE full_name LIKE 'St. Louis Blues';
UPDATE display_names SET url='http://lightning.nhl.com/' WHERE full_name LIKE 'Tampa Bay Lightning';
UPDATE display_names SET url='http://mapleleafs.nhl.com/' WHERE full_name LIKE 'Toronto Maple Leafs';
UPDATE display_names SET url='http://canucks.nhl.com/' WHERE full_name LIKE 'Vancouver Canucks';
UPDATE display_names SET url='http://capitals.nhl.com/' WHERE full_name LIKE 'Washington Capitals';

