import { hash } from 'bcrypt';
import { randomUUID } from 'crypto';
import { UserRepository as Repository } from '../repositories/user_repository';

export class UserService {
    static async createUser(email: string, firstName: string, lastName: string, password: string) {
        const uuid = randomUUID();
        const passwordHash = await hash(password, 12);
        return Repository.createUser(uuid, email, firstName, lastName, passwordHash);
    }

    static async getUsers() {
        return Repository.getUsers();
    }
}
