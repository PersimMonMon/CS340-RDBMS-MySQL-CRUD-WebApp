//Citation for the following file, all except the .post and reset functions
//Date: 11/02/2025
//Copied from Exploration - Web Application Technology Module 6 CS340
//https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131

// Format the date line 74
// Citation for use of AI Tools:
// Date: 11/02/2025
// Prompts used: in this how do I format the date so it's just day month year?        
// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 62777;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/directors', async function (req, res) {
    try {
        // Create and execute our queries
        // In query1, we use a SELECT clause to display the directors
        const query1 = 'SELECT directorID, firstName, lastName, email FROM Directors ORDER BY lastName;';
        const [directors] = await db.query(query1);

        // Render the directors.hbs file
        res.render('directors', { directors: directors });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/shows', async function (req, res) {
    try {
        // Create and execute our queries
        // In query1, we use a JOIN clause to display the directors
        const query1 = 
            `SELECT Shows.showID, Shows.date, Directors.firstName, Directors.lastName
            FROM Shows
            LEFT JOIN Directors ON Shows.directorID = Directors.directorID
            ORDER BY Shows.date;
        `;
        const [shows] = await db.query(query1);
        // Fomart the dates
        const formattedShows = shows.map(show => {
            const date = new Date(show.date);
            show.date = date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
            return show;
        });
        // Render the shows.hbs file
        res.render('shows', { shows: shows });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});


app.get('/actors', async function (req, res) {
    try {
        // Create and execute our queries
        // In query1, we use a SELECT clause to display the actors
        const query1 = 'SELECT actorID, firstName, lastName, email FROM Actors ORDER BY lastName;'
        const [actors] = await db.query(query1);

        // Render the actors.hbs file
        res.render('actors', { actors: actors });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/skits', async function (req, res) {
    try {
        // Create and execute our queries
        // In query1, we use a JOIN clause to display the show date and author
        const query1 = 
            `SELECT Skits.skitID, Skits.title, Skits.description,
            Shows.date AS show_date, Actors.firstName, Actors.lastName
            FROM Skits
            LEFT JOIN Shows ON Skits.showID = Shows.showID
            LEFT JOIN Actors ON Skits.authorID = Actors.actorID
            ORDER BY Skits.title`
        const [skits] = await db.query(query1);

        // Format the date
        // Citation for use of AI Tools:
        // Date: 11/02/2025
        // Prompts used: in this how do I format the date so it's just day month year?
        const formattedSkits = skits.map(skit => {
            if (skit.show_date) { // make sure the show date exists
                const date = new Date(skit.show_date);
                skit.show_date = date.toLocaleDateString('en-US', {
                    month: 'short',
                    day: 'numeric',
                    year: 'numeric'
                });
            }
            return skit;
        });
        // Render the skits.hbs file
        res.render('skits', { skits: skits });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/skit-actors', async function (req, res){
    try{
        const query1 = `
        SELECT SkitActors.skitID, SkitActors.actorID, SkitActors.role, Skits.title,
        Actors.firstName, Actors.lastName
        FROM SkitActors
        JOIN Skits ON SkitActors.skitID = Skits.skitID
        JOIN Actors ON SkitActors.actorID = Actors.actorID
        ORDER BY Skits.title;
        `;
        const query2 = `
        SELECT skitID, title
        FROM Skits
        ORDER BY title;
        `;
        const query3 = `
        SELECT actorID, firstName, lastName
        FROM Actors
        ORDER BY lastName;
        `;

        const [skitactors] = await db.query(query1);
        const [skits] = await db.query(query2);
        const [actors] = await db.query(query3);

        res.render('skit-actors', {skitactors: skitactors, skits: skits, actors: actors });
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).send('An error occurred while executing the database queries.');
    }
})

// CREATE ROUTES
app.post('/skit-actors/create', async function (req, res) {
    try {
        let data = req.body;

        const query = `CALL sp_CreateSkitActor(?, ?, ?);`;
        await db.query(query, [
            data.create_skitactor_skit,
            data.create_skitactor_actor,
            data.create_skitactor_role
        ]);

        console.log(`CREATE SkitActor. SkitID: ${data.create_skitactor_skit}, ` +
            `ActorID: ${data.create_skitactor_actor}, 
            Role: ${data.create_skitactor_role}`);
        
        res.redirect('/skit-actors');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send('An error occurred while executing the database queries.');
    }
});

// Reset Skit Actors 
app.post('/skit-actors/reset', async (req, res) => {   
    console.log('Received POST request.')
    try { 
        const [result] = await db.query('CALL sp_ResetSkitActors();')
        console.log('Skit Actors data has been reset.')
        res.json('Skit Actors data has been reset.')
    } catch (error) {
        console.error('Error executing query', error);
        res.status(500).send('An error occurred while executing the database queries.');
    }
});

// Update Routes
// Citation for use of AI Tools for line 225:
// Date: 11/23/2025
// Prompts used: How can I break the compsite key skitID ActorID into two and store
// both as a variable
app.post('/skit-actors/update', async function (req, res) {
    try {
        let data = req.body;
        
        const [oldSkitID, oldActorID] = data.update_skitactor_select.split('-');

        const query = `CALL sp_UpdateSkitActor(?, ?, ?, ?, ?);`;
        await db.query(query, [
            oldSkitID,
            oldActorID,
            data.update_skitactor_new_skit,
            data.update_skitactor_new_actor,
            data.update_skitactor_new_role
        ]);

        console.log(`UPDATE SkitActor, Old: (${oldSkitID}, ${oldActorID})` 
            + `${data.update_skitactor_new_skit}, ` +
            `ActorID: ${data.update_skitactor_new_actor}, ` +
            `Role: ${data.update_skitactor_new_role}`);
        
        res.redirect('/skit-actors');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send('An error occurred while executing the database queries.');
    }
});


// Delete Route
app.post('/skit-actors/delete', async function (req, res) {
    try {
        let data = req.body;
        
        const skitID = data.delete_skitactor_skitID;
        const actorID = data.delete_skitactor_actorID
        const query = `CALL sp_DeleteSkitActor(?, ?);`;
        await db.query(query, [
            skitID,
            actorID,
        ]);

        console.log(`DELETE SkitActor, (${skitID}, ${actorID})` );
        
        res.redirect('/skit-actors');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send('An error occurred while executing the database queries.');
    }
});

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});