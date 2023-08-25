from tkinter import *
import sqlite3

#GUI
root = Tk()
root.title('players_db')
root.iconbitmap('ball.ico')
root.geometry("550x650")

#Database
conn = sqlite3.connect('players_data.db')

#Create cursor
c = conn.cursor()

#Create table

c.execute("""CREATE TABLE IF NOT EXISTS footballers (
        first_name text,
        last_name text,
        position text,
        number integer,
        clubs_club_name,
        FOREIGN KEY(clubs_club_name) REFERENCES clubs(club_name)
        )""")
c.execute("""CREATE TABLE IF NOT EXISTS clubs (
        club_name text,
        club_country text,
        club_city text
        )""")


def submit():
    #Connect with db
    conn = sqlite3.connect('players_data.db')

    # Create cursor
    c = conn.cursor()

    #Enter data to table
    c.execute("INSERT INTO footballers VALUES(:f_name, :l_name, :position, :number, :club_name)",
              {'f_name': f_name.get(), 'l_name': l_name.get(), 'position': position.get(), 'number': number.get(),
                  'club_name': club.get()})
    c.execute("INSERT INTO clubs VALUES(:club_name, :club_country, :club_city)",
              {'club_name': club.get(), 'club_country': club_country.get(), 'club_city': club_city.get()})

    conn.commit()
    conn.close()

    #Clear input
    f_name.delete(0, END)
    l_name.delete(0, END)
    position.delete(0, END)
    number.delete(0, END)
    club.delete(0, END)
    club_country.delete(0, END)
    club_city.delete(0, END)


def show_one():
    global show_label, show_label2

    #Clear label showing players data
    show_label.grid_forget()
    show_label2.grid_forget()

    #Connect to db
    conn = sqlite3.connect('players_data.db')
    c = conn.cursor()

    #Show data
    c.execute("SELECT *, oid from footballers WHERE oid= " + delete_box.get())
    records = c.fetchall()
    c.execute("SELECT *, oid FROM clubs WHERE oid= " + delete_box.get())
    records2 = c.fetchall()

    #Show every row
    print_records = str(records[0][5]) + " " + str(records[0][0]) + " " + str(records[0][1]) + " " + str(
        records[0][2]) + " " + str(records[0][3]) + "      ""      " + str(records[0][4]) + "\n"
    print_records2 = str(records2[0][1]) + " " + str(records2[0][2]) + "\n"
    show_label = Label(root, text=print_records)
    show_label.grid(row=14, column=0, columnspan=2)

    show_label2 = Label(root, text=print_records2)
    show_label2.grid(row=14, column=2, columnspan=2)

    conn.commit()
    conn.close()


def delete():
    conn = sqlite3.connect('players_data.db')
    c = conn.cursor()

    #Delete row
    c.execute("DELETE from footballers WHERE oid= " + delete_box.get())
    c.execute("DELETE from clubs WHERE oid= " + delete_box.get())

    conn.commit()
    conn.close()


def show_all():
    global show_label, show_label2

    show_label.grid_forget()
    show_label2.grid_forget()

    conn = sqlite3.connect('players_data.db')
    c = conn.cursor()

    #Show all data
    c.execute("SELECT *, oid FROM footballers")
    records = c.fetchall()
    c.execute("SELECT *, oid FROM clubs")
    records_clubs = c.fetchall()

    print_records = ""
    print_records2 = ""
    for record in records:
        print_records += str(record[5]) + " " + str(record[0]) + " " + str(record[1]) + " " + str(
            record[2]) + " " + str(record[3]) + "\n"
    for record in records_clubs:
        print_records2 += str(record[0]) + " " + str(record[1]) + " " + str(record[2]) + "\n"

    #if empty db
    if print_records2 == '' and print_records2 == '':
        show_label = Label(root, text="Brak danych!")
        show_label.grid(row=14, column=0, columnspan=4)
    else:
        show_label = Label(root, text=print_records)
        show_label.grid(row=14, column=0, columnspan=2)

        show_label2 = Label(root, text=print_records2)
        show_label2.grid(row=14, column=2)

    conn.commit()
    conn.close()


#Entry GUI
f_name = Entry(root, width=30)
f_name.grid(row=0, column=1, padx=20, pady=(10, 0))
l_name = Entry(root, width=30)
l_name.grid(row=1, column=1, padx=20)
position = Entry(root, width=30)
position.grid(row=2, column=1, padx=20)
number = Entry(root, width=30)
number.grid(row=3, column=1, padx=20)
club = Entry(root, width=30)
club.grid(row=4, column=1, padx=20, pady=(20, 0))
club_country = Entry(root, width=30)
club_country.grid(row=5, column=1, padx=20)
club_city = Entry(root, width=30)
club_city.grid(row=6, column=1, padx=20)
delete_box = Entry(root, width=30)
delete_box.grid(row=10, column=1, pady=10)

# GUI table
f_name_label = Label(root, text="Name", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
f_name_label.grid(row=0, column=0, pady=(10, 0))
l_name_label = Label(root, text="Surname", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
l_name_label.grid(row=1, column=0)
position_label = Label(root, text="Position", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
position_label.grid(row=2, column=0)
number_label = Label(root, text="Number", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
number_label.grid(row=3, column=0)
club_label = Label(root, text="Club", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
club_label.grid(row=4, column=0, pady=(20, 0))
club_country_label = Label(root, text="Club country", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
club_country_label.grid(row=5, column=0)
club_city_label = Label(root, text="Club city", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
club_city_label.grid(row=6, column=0)
delete_box_label = Label(root, text="ID", bd=5, bg='black', fg='white', relief=GROOVE, width=15)
delete_box_label.grid(row=10, column=0)

#buttons
submit_button = Button(root, text="Add to database", command=submit, bg='dark green', fg='white', bd=5)
submit_button.grid(row=7, column=0, columnspan=2, pady=10, padx=10, ipadx=120)

show_button = Button(root, text="Show all data", command=show_all, bg='turquoise4', fg='white', bd=5)
show_button.grid(row=8, column=0, columnspan=2, pady=5, padx=10, ipadx=128)

delete_button = Button(root, text="Delete record", command=delete, bg='firebrick3', fg='white', bd=5)
delete_button.grid(row=13, column=0, columnspan=2, pady=10, padx=10, ipadx=127)


def edit():
    conn = sqlite3.connect('players_data.db')
    c = conn.cursor()

    #Show data
    c.execute("SELECT *, oid from footballers WHERE oid= " + delete_box.get())
    records = c.fetchall()
    c.execute("SELECT *, oid from clubs WHERE oid= " + delete_box.get())
    record2 = c.fetchall()

    # Lista1->>data from db
    list1 = []
    list1.extend(
        [records[0][0], records[0][1], records[0][2], records[0][3], records[0][4], records[0][5], record2[0][1],
         record2[0][2]])

    # Lista2->>data from widget entry
    list2 = [f_name.get(), l_name.get(), position.get(), number.get(), club.get(), club.get(), club_country.get(),
             club_city.get()]


    if list1 == list2 or list2 == ['', '', '', '', '', '', '', '']:
        f_name.delete(0, END)
        l_name.delete(0, END)
        position.delete(0, END)
        number.delete(0, END)
        club.delete(0, END)
        club_country.delete(0, END)
        club_city.delete(0, END)

        for record in records:
            f_name.insert(0, record[0])
            l_name.insert(0, record[1])
            position.insert(0, record[2])
            number.insert(0, record[3])
            club.insert(0, record[4])
        for record in record2:
            club_country.insert(0, record[1])
            club_city.insert(0, record[2])



    else:
        record_id = delete_box.get()
        #update data in table
        c.execute("""UPDATE footballers SET
                first_name = :first,
                last_name = :last,
                position = :position,
                number = :number,
                clubs_club_name= :club_name
             
                WHERE oid = :oid""",
                  {'first': f_name.get(), 'last': l_name.get(), 'position': position.get(), 'number': number.get(),
                      'club_name': club.get(), 'oid': record_id

                  })
        c.execute("""UPDATE clubs SET
                     club_name = :name,
                     club_country = :country,
                     club_city = :city

                        WHERE oid = :oid""",
                  {'name': club.get(), 'country': club_country.get(), 'city': club_city.get(), 'oid': record_id

                  })

        f_name.delete(0, END)
        l_name.delete(0, END)
        position.delete(0, END)
        number.delete(0, END)
        club.delete(0, END)
        club_country.delete(0, END)
        club_city.delete(0, END)

    conn.commit()
    conn.close()


# buttons
edit_button = Button(root, text="Edit record", command=edit, bg='orange', fg='white', bd=5)
edit_button.grid(row=12, column=0, columnspan=2, pady=10, padx=10, ipadx=133)

show_record_button = Button(root, text="Show record", command=show_one, bg='turquoise4', fg='white', bd=5)
show_record_button.grid(row=11, column=0, columnspan=2, pady=10, padx=10, ipadx=130)

show_label = Label(root)
show_label.grid(row=14, column=0, columnspan=2)
show_label2 = Label(root)
show_label2.grid(row=14, column=2, columnspan=2)

conn.commit()
conn.close()

root.mainloop()
