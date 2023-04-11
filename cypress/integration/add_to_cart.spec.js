describe('product details', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it('can add items to cart', () => {
    cy.contains('My Cart (0)').should('exist');
    cy.get('button').contains('Add').first().click();
    cy.contains('My Cart (1)').should('exist');
  });
});
