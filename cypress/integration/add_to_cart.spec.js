describe("home", () => {
  beforeEach(() => {
    cy.visit("/");
  });
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  it("cart button count changes when a product is added to cart", () => {
    cy.get(".products article").first().within(() => {
      cy.get("div > form > .btn").click({force: true});
    });
    cy.get("nav").contains("My Cart (1)");
  });
});
