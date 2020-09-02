# Question 1. Which students are enrolled with a last name ‘Ben’? Show their last names, first names, age, and gender. 
# Order by gender, and then age.
SELECT * FROM student
	WHERE LastName = "Ben"
    ORDER BY gender, age;
    
# 2.	What are the studentIDs, first names, and last names of the students that have failed at least one course?
# Assume F is FAIL
SELECT StudentID, LastName, FirstName from student
	WHERE StudentID IN 
		(SELECT DISTINCT STUDENTID FROM enrollment WHERE GRADE = "F");
        
# 3.	Which students (by studentID) have gotten a grade of ‘D’ or ‘F’ for at least one course?
SELECT StudentID, LastName, FirstName from student
	WHERE StudentID IN 
		(SELECT DISTINCT STUDENTID FROM enrollment WHERE GRADE = "F" OR GRADE = "D");
        
# 4.	What are the studentIDs, first names and last names of the students who have been taught by John Chua?  
# 		Sort the students in alphabetical order by last name.
SELECT StudentID, LastName, FirstName from student
	WHERE StudentID IN 
		(SELECT DISTINCT STUDENTID FROM enrollment
			WHERE InstructorID = (SELECT InstructorID FROM Instructor WHERE LastName = "John" AND FirstName = "Chua"))
		ORDER BY LastName;
        
# 5.	How many sections of any course has John Chua taught in Semester 2 2018?
SELECT COUNT(SectionID) amt_section_john FROM section
	WHERE InstructorID = (SELECT InstructorID FROM Instructor WHERE LastName = "John" AND FirstName = "Chua")
    AND Sem = 2;

# 6.	How many students are taking each section of 8881 taught by Kris Tan in Semester 1 2018?
SELECT COUNT(*) amt_student FROM enrollment INNER JOIN (SELECT * FROM section
	WHERE InstructorID = (SELECT InstructorID FROM instructor WHERE LastName = "Kris" AND FirstName = "Tan")
    AND Year = 2018 
    AND Sem = 1
    AND CourseID = 8881) tempTable
	ON enrollment.CourseID = tempTable.CourseID AND enrollment.Sem = tempTable.Sem AND enrollment.Year = tempTable.Year AND enrollment.InstructorID = tempTable.InstructorID;

#7.	Which students (by name) have taken at least three courses from 2017-2018?
SELECT * FROM student 
	WHERE StudentID in (SELECT StudentID 
						FROM enrollment 
						WHERE (Year BETWEEN 2017 AND 2018) 
						GROUP BY StudentID
						HAVING count(StudentID) >= 3);
													
#8.	Which instructors teach at least 3 sections in Semester 2 2018?
# Sub-query to obtain number of sections taught in 2018 S2
SELECT InstructorID FROM enrollment
	WHERE (Year = 2018 AND Sem = 2)
    GROUP BY InstructorID
    HAVING COUNT(DISTINCT SectionID) >= 3;

SELECT *  FROM instructor
	WHERE InstructorID IN (SELECT InstructorID FROM enrollment
							WHERE (Year = 2018 AND Sem = 2)
							GROUP BY InstructorID
                            HAVING COUNT(DISTINCT SectionID) >= 3);
                            
#9.	Which students (by name) have obtained at least 3 ‘A’ grades from 2017-2018?
  
# Sub-query to obtain records of student grades == 'A'
SELECT StudentID, COUNT(*) numOfA FROM enrollment WHERE Grade = "A" GROUP BY StudentID;

SELECT * FROM student WHERE StudentID IN 
	(SELECT StudentID FROM 
		(SELECT StudentID, COUNT(*) numOfA 
		FROM enrollment 
        WHERE Grade = "A" 
        GROUP BY StudentID) tempTable 
        WHERE numOfA >= 3);

#10.	Create a new record for a new course called ‘Advanced Database Development’ (CourseID: 8887).  The course has 4 course credits.
INSERT INTO course (CourseName, CourseID, CourseCredit) VALUES ("Advanced Database Development", 8887, 4);
SELECT * FROM course;

#11.	Add the instructor “WuShin Yi” with instructor ID 5507.
INSERT INTO instructor (InstructorID, LastName, FirstName) VALUES (5507, "WuShin", "Yu");
Select * FROM instructor;
# As WuSin Yu was at 5507, update the record instead of insert.
UPDATE instructor 
	SET
		LastName = "WuShin"
	WHERE InstructorID = 5507;


#12.	Add that ‘WuShin Yi’ teaches the section 15 for Advanced Database Development (couseID: 8887) in Semester 1 2018.  
SELECT * FROM courseinsemester;
INSERT INTO courseinsemester (CourseID, Sem, Year, InstructorID) 
	VALUES 
		(8887, 1, 2018, (SELECT InstructorID FROM instructor WHERE LastName = "WuShin" AND FirstName = "Yi"));

INSERT INTO section (CourseID, Sem, Year, InstructorID, SectionID) 
	VALUES
		(8887, 1, 2018, (SELECT InstructorID FROM instructor WHERE LastName = "WuShin" AND FirstName = "Yi"), 15);

#13.	The course called ‘Advanced Database Development’ is to be recoded as ‘9887.’ 
# 		(You can assume that cascade on update is implemented on FKs)
# Remove #9887 cause it was already in there
DELETE FROM course where CourseID = 9887; 

UPDATE course
	SET CourseID = 9887
    WHERE CourseName = "Advanced Database Development";


#14.	The instructor ‘John Chua’ is very generous.  Every student in his class for 2018 Sem 1 is going to get an ‘A.’
# Sub-query to extract John Chua's InstructorID
SELECT InstructorID FROM instructor WHERE LastName = "John" AND FirstName = "Chua";
# Extract all of John Chua's Students
SELECT * FROM enrollment
	WHERE (Year = 2018 AND Sem = 1 AND InstructorID	= (SELECT InstructorID FROM instructor WHERE LastName = "John" AND FirstName = "Chua"));

## PROBLEM ##
UPDATE enrollment
	SET
		Grade = "A"
	WHERE
		InstructorID = (SELECT InstructorID FROM instructor WHERE LastName = "John" AND FirstName = "Chua")
        AND Year = 2018
        AND Sem = 1;
        
        
#15.	Show all students who are not taking a course in Semester 2 2018.
SELECT * FROM student WHERE StudentID NOT IN (SELECT DISTINCT StudentID FROM enrollment WHERE Sem = 2 AND Year = 2018);

#16.	Show instructors who have never taught a course.
SELECT DISTINCT InstructorID FROM courseinsemester;
SELECT * FROM instructor WHERE InstructorID not in (SELECT DISTINCT InstructorID FROM enrollment);

#17.	Count the number of courses each instructor has ever taught.  Remember, some instructors can teach no classes.
SELECT instructor.*, COUNT(DISTINCT CourseID) course_taught FROM instructor LEFT JOIN enrollment
	ON instructor.InstructorID = enrollment.InstructorID
    GROUP BY InstructorID
    ORDER BY course_taught DESC;