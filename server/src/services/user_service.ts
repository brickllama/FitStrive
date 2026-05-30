import { compare, hash } from 'bcrypt';
import { randomUUID } from 'crypto';
import { UserRepository as Repository } from '../repositories/user_repository';

export class UserService {

    static async delete(uuid: string) {
        return Repository.remove(uuid);
    }

    static async getAll() {
        return Repository.getAll();
    }

    static async login(email: string, password: string) {
        const user = await Repository.getByEmail(email);
        if (!user) {
            return null;
        }
        const validPassword = await compare(password, user.passwordHash);
        if (!validPassword) {
            return null;
        }
        return {
            uuid: user.uuid,
            email: user.email,
            firstName: user.firstName,
            lastName: user.lastName
        };
    }

    static async register(email: string, firstName: string, lastName: string, password: string) {
        const uuid = randomUUID();
        const passwordHash = await hash(password, 12);
        return Repository.create(uuid, email, firstName, lastName, passwordHash);
    }
}
