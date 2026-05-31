import pool from '../db/pool';

export class UserRepository {

    static async create(
        uuid: string,
        email: string,
        username: string,
        firstName: string,
        lastName: string,
        passwordHash: string
    ) {
        const result = await pool.query(
            `INSERT INTO users (uuid, email, username, first_name, last_name, password_hash)
            VALUES ($1, $2, $3, $4, $5, $6)
            ON CONFLICT (email)
            DO NOTHING
            RETURNING uuid, email, username, first_name, last_name`,
            [uuid, email, username, firstName, lastName, passwordHash]
        );
        if (result.rows.length === 0) {
            return null; // USER exists?
        }
        var row = result.rows[0];
        return {
            uuid: row.uuid,
            email: row.email,
            username: row.username,
            firstName: row.first_name,
            lastName: row.last_name
        };
    }

    static async remove(uuid: string) {
        const result = await pool.query(
            `DELETE FROM users
            WHERE uuid = $1`,
            [uuid]
        );
        return result.rowCount !== 0;
    }

    static async getAll() {
        const result = await pool.query(
            `SELECT uuid, email, username, first_name, last_name FROM users`
        );
        if (result.rows.length === 0) {
            return null; // USERS dont exist???
        }
        return result.rows;
    }

    static async getByEmail(email: string) {
        const result = await pool.query(
            `SELECT uuid, email, username, first_name, last_name, password_hash FROM users
            WHERE email = $1`,
            [email]
        );
        if (result.rows.length === 0) {
            return null; // USER doesnt exist???
        }
        var row = result.rows[0];
        return {
            uuid: row.uuid,
            email: row.email,
            username: row.username,
            firstName: row.first_name,
            lastName: row.last_name,
            passwordHash: row.password_hash
        };
    }
}
