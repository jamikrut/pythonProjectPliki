class Enemy:
    def __int__(self, name='Enemy', health=0, hit_power=0):
        self.name = name
        self.health = health
        self.hit_power = hit_power

    def take_damage(self, damage):
        ramining_health = self.health - damage
        if remaining_health > 0:
            self.
