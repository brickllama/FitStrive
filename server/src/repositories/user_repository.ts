import pool from '../db/pool';

/**
 * Handles user persistence.
 */
export class UserRepository {

    /**
     * Registers a new user in the database.
     * @param uuid - User UUID.
     * @param email - User email.
     * @param name - User name.
     * @param passwordHash 
     * @returns The created `UserDTO`.
     */
    static async createUser(uuid: string, email: string, name: string, passwordHash: string) {
        const result = await pool.query(
            `INSERT INTO users (uuid, email, name, password_hash)
            VALUES ($1, $2, $3, $4)
            RETURNING uuid, email, name`,
            [uuid, email, name, passwordHash]
        );
        return result.rows[0];
    }

    /**
     * Gets all users in the database.
     * @returns `UserDTO[]`.
     */
    static async getAllUsers() {
        const result = await pool.query(`SELECT uuid, email, name FROM users`);
        return result.rows;
    }

    /**
     * Gets a user by email.
     * @param email - The user's email
     * @returns `UserDTO`.
     */
    static async getUserByEmail(email: string) {
        const result = await pool.query(
            `SELECT uuid, email, name FROM users WHERE email = $1`,
            [email]
        );
        return result.rows[0];
    }

    /**
     * Gets a user by UUID.
     * @param uuid - The user's UUID.
     * @returns `UserDTO`.
     */
    static async getUserByUuid(uuid: string) {
        const result = await pool.query(
            `SELECT uuid, email, name FROM users WHERE uuid = $1`,
            [uuid]
        );
        return result.rows[0];
    }
}
