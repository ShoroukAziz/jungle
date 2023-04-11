describe('user authentication', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it('can login a registered user', () => {
    cy.get('a').contains('Login').click();
    cy.url().should('eq', 'http://127.0.0.1:3000/login');
    cy.get('input[name="email"]').first().type('example@email.com');
    cy.get('input[name="password"]').type('123456');
    cy.get('input').contains('Login').click();
    cy.contains('Login').should('not.exist');
    cy.contains('Log out').should('exist');
    cy.url().should('eq', 'http://127.0.0.1:3000/');
  });

  it('can sign up a new user', () => {
    cy.get('a').contains('Sign up').click();
    cy.url().should('eq', 'http://127.0.0.1:3000/signup');
    cy.get('#user_first_name').click({ force: true }).type('Shorouk');
    cy.get('#user_last_name').click({ force: true }).type('Abdelaziz');
    cy.get('#user_email').click({ force: true }).type('email@domain.com');
    cy.get('#user_password').click({ force: true }).type('123456');
    cy.get('#user_password_confirmation').click({ force: true }).type('123456');
    cy.get('input').contains('Sign up').click();
    cy.contains('Login').should('not.exist');
    cy.contains('Log out').should('exist');
    cy.url().should('eq', 'http://127.0.0.1:3000/');
  });
});
