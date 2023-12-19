self: super: {
  website = self.callPackage ./website { };
  update-website = self.callPackage ./update-website { };
}
