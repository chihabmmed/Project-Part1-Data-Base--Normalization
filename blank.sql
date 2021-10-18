--  -- 

-- **step 1: Find Redundant Columns** --
-- -> venue_ table 
/*  
- All of these columns are redundant from another table city: country, localized_country_name, state
- These columns offer no additional useful information and take more space: 
*/

-- -> grp table 
/*
- All of the colums are informational and there is no column redundancy
*/

-- -> city table
/*
- All these columns only take more space, and are redundant since the company operates only in one country: "localized_country_name" and "country".
and distance is not of informational value in this table
 */

-- -> event table
/*
All of these columns are not of informational value to the table: "maybe_rsvp_count", "headcount", "utc_offset", "why", "visibility".
*/

-- -> category table
/*
These columns carry redundant information from another column: "sort_name", "short_name".
*/



-- **step 2: Eliminate Redundant Columns** --

-- -> 1) drop "address_2" column  from venue_ table
ALTER TABLE venue_ 
	DROP COLUMN  address_2;
/*
"Address_2" column contains no usefull information. It contains only NULL values.
*/

-- -> 2) drop "localized_country_name" column from city table
ALTER TABLE city 
	DROP COLUMN  localized_country_name;

/*
"localized_country_name" column is redundant of the column 'country', and does not add value to the table, since the company operates only in one contry, and thus, take more memory space.
*/


-- -> 3) drop "why" column from event table
ALTER TABLE event 
	DROP COLUMN  why;
/*
"why" column contains not valuable information. Its distinct value is "not_found", which only takes extra memory space.
*/


-- -> 4) drop "shortname" from category table
ALTER TABLE category 
	DROP COLUMN  shortname;
/*
"shortname" column carries redundant repetitive information from the category column. Thus, it will only eat up more memory space.
*/


-- -> 5) drop "country" from grp_member table
ALTER TABLE grp_member 
	DROP COLUMN  country;
/*
"country" column is not of valuable information, since the company operates in one single country. Thus, it is redundant.
*/


-- **step 3: Split grp_member table** --

-- A) creating "group_sign_ups" table
CREATE TABLE group_sign_ups AS
	SELECT DISTINCT group_id, member_id, joined
		FROM grp_member;


-- B) creating "members" table
CREATE TABLE members AS
	SELECT DISTINCT member_id, member_name, city, hometown, member_status
		FROM grp_member;

-- C) Altering "members" table to include primary key
ALTER TABLE members
	ADD PRIMARY KEY (member_id);

-- D) Altering "group_sign_ups" table to inlude a foreign key that references "members" table
ALTER TABLE group_sign_ups
	ADD FOREIGN KEY (member_id) REFERENCES members (member_id);

-- D) Altering "group_sign_ups" table to inlude a foreign key that references "grp" table
ALTER TABLE group_sign_ups
	ADD FOREIGN KEY (group_id) REFERENCES grp (group_id);

-- E) Dropping "grp" table
DROP TABLE grp_member;


-- **step 4: creating a new ERD** --
-- Open and check Model












